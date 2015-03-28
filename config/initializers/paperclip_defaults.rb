Paperclip::Attachment.default_options.merge!(
    #:path => :rails_root/public/system/:class/:attachment/:id_partition/:style/:filename,
    :path => ':rails_root/public/system/:class/:attachment/:id_partition/:style/:basename.:extension',
    :default_style => :prethumb
)