if defined? ActionDispatch::Http::UploadedFile
  ActionDispatch::Http::UploadedFile.send(:include, Paperclip::Upfile)
end
Paperclip.options[:command_path] = "/usr/local/bin"