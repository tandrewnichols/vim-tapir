if has('syntax')
  syn match TapirStatus              "\d\d\d [A-Za-z ]\+$"
  syn match TapirProtocol            "^HTTP\/\d\.\d" contains=TapirStatus
  syn match TapirHeader              "^\zs[A-Z][A-Za-z-]\+\ze: "

  hi def link TapirProtocol          Keyword
  hi def link TapirStatus            String
  hi def link TapirHeader            Structure
endif
