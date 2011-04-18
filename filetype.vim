augroup filetypedetect
  au BufRead,BufNewFile *.m	setf objc "Objective-C
  au BufNewFile,BufRead *.scala setf scala " Scala
  au BufNewFile,BufRead *.thrift setfiletype thrift " Thrift
  au BufNewFile,BufRead *.as setfiletype actionscript " Actionscript
  au BufNewFile,BufRead *.mxml setfiletype mxml " MXML files
augroup END

