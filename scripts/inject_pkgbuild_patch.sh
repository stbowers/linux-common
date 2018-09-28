#!/bin/bash

if (($#<2)); then
    echo "Please supply: (1) PKGBUILD file, (2-N) patch file(s) ; arguments"
    exit 1
fi

pkgbuild="${1}"
patch_files="${@:2}"

mv "${pkgbuild}" "${pkgbuild}.bak"
awk -vpatch_files="${patch_files}" \
'function get_sha512hash(target_file,
    command_sha512_sum, sha_hash)
{
    command_sha512_sum=("sha512sum " target_file)
    command_sha512_sum | getline sha_hash
    close(command_sha512_sum)
    sub("[[:blank:]].*$", "", sha_hash)

    return sha_hash
}

BEGIN{
    patch_count=split(patch_files, array_patch_files)
    for (i=1 ; i<=patch_count ; ++i)
        array_sha_hashes[i]=get_sha512hash(array_patch_files[i])
    array_sha_hashes[0]=patch_count
}

{
    array_lines[++line]=$0
}

END{
    line_count=line
    for (line=1 ; line<=line_count ; ++line) {
        $0=array_lines[line]
        source_open=source_open || ($1 ~ "^source=")
        sha512sums_open=sha512sums_open || ($1 ~ "sha512sums")
        if (($1 == "sed") && ($NF == "$pkgname/configure*") && !patchset_done) {
            for (i=1 ; i<=patch_count ; ++i)
                printf(" %s %s\n", "patch -d $pkgname -p1 <", array_patch_files[i])
            printf("\n")
            patchset_done=1
        }
        do_print_array=((source_open || sha512sums_open) && sub("[)]$",""))
        printf("%s\n", $0)
        if (!do_print_array)
            continue

        for (i=1 ; i<=patch_count ; ++i) {
            if (sha512sums_open)
                sub("\x27[[:alnum:]]*\x27", ("\x27" array_sha_hashes[i] "\x27"))
            else
                sub("[[:alnum:]][-_.[:alnum:]]*", array_patch_files[i])
            if (i==patch_count)
                sub("$",")")
            printf("%s\n", $0)
        }
        source_open=sha512sums_open=0
    }
}' "${pkgbuild}.bak" > "${pkgbuild}" 2>/dev/null
