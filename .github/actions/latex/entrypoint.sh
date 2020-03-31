#!/bin/bash
set -eux
# target settings
dirpath=""
texfilename="paper"

# build pdf (change if necessary)
cd "${dirpath}"
latexmk "${texfilename}"
# rename pdf (e.g. [texfilename]-v1.0.0.pdf)
pdfname="${texfilename}-$(echo ${GITHUB_REF:10}).pdf"
mv "${texfilename}.pdf" ${pdfname}

# create release
res=`curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
-d "
{
  \"tag_name\": \"$(echo ${GITHUB_REF:10})\",
  \"target_commitish\": \"$GITHUB_SHA\",
  \"name\": \"$(echo ${GITHUB_REF:10})\",
  \"draft\": false,
  \"prerelease\": false
}"`

# extract release id
rel_id=`echo ${res} | python3 -c 'import json,sys;print(json.load(sys.stdin).get("id","exist"))'`

if [ $rel_id = "exist" ]; then
  echo "Already exist."
  res=`curl -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$GITHUB_REPOSITORY/releases/tags/${GITHUB_REF:10}"`

  # extract release id
  rel_id=`echo ${res} | python3 -c 'import json,sys;print(json.load(sys.stdin).get("id","exist"))'`
else
  echo "Created a new release."
fi

# upload built pdf
curl -H "Authorization: token $GITHUB_TOKEN" -X POST https://uploads.github.com/repos/$GITHUB_REPOSITORY/releases/${rel_id}/assets?name=${pdfname}\
  --header 'Content-Type: application/pdf'\
  --upload-file ${pdfname}
