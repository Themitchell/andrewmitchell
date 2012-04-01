if Rails.env.staging? || Rails.env.production?
  PAPERCLIP_OPTIONS = { :whiny          => false,
                        :storage        => :s3,
                        :bucket         => ENV['FOG_DIRECTORY'],
                        :s3_credentials => { :access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
                                             :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                                           },
                        :path => "uploaded/:class/:attachment/:id/:style/:basename.:extension"
                      }
elsif Rails.env.development?
  PAPERCLIP_OPTIONS = { :whiny => false,
                        :url => "dev_uploaded/:class/:attachment/:id/:style/:basename.:extension",
                        :path => ":rails_root/app/assets/images/dev_uploaded/:class/:attachment/:id/:style/:basename.:extension"
                      }
elsif Rails.env.test? || Rails.env.cucumber?
  PAPERCLIP_OPTIONS = { :whiny => false,
                        :url => "test_uploaded/:class/:attachment/:id/:style/:basename.:extension",
                        :path => ":rails_root/app/assets/images/test_uploaded/:class/:attachment/:id/:style/:basename.:extension"
                      }
end
                
IMAGE_MIME_TYPES = [
    'image/jpeg',
    'image/gif',
    'image/png',
    # Grrrr... IE
    'image/pjpeg',
    'image/jpg',
    'image/x-png',
]