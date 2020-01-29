{ pkgs, generatedJson ? "/tmp/xchg/coverage-data/phpinfo.json"
, output, sampleJson, excludes ? [ ] }:

let
  python = pkgs.python37mj.withPackages (ps: with ps; [ deepdiff ]);
in

pkgs.writeScript "test-php-diff.py" ''
  #!/${python}/bin/python

  import json
  from deepdiff import DeepDiff, DeepHash, DeepSearch, grep

  # Original JSON
  with open('${sampleJson}') as json_file:
    data1 = json.load(json_file)

  # JSON generated by the Apache in the container
  with open('${generatedJson}') as json_file:
    data2 = json.load(json_file)

  # Generate diff result
  with open('${output}', 'w') as outfile:
    outfile.write(DeepDiff(data1, data2, ignore_order=True${
      if (builtins.length excludes == 0) then
        ""
      else
        ", exclude_paths=[" + builtins.concatStringsSep ", "
        (map (str: ''"'' + str + ''"'') excludes) + "]"
    }).to_json())
''
