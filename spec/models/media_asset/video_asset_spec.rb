# == Schema Information
#
# Table name: media_assets
#
#  id                         :integer         not null, primary key
#  media_id                   :string(255)
#  type                       :string(255)
#  hosting_location_key       :string(255)
#  splash_screen_file_name    :string(255)
#  splash_screen_content_type :string(255)
#  splash_screen_file_size    :integer
#  owner_id                   :integer
#  owner_type                 :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#

require File.expand_path(File.dirname(__FILE__) + '../../../support/spec_helper')

describe MediaAsset::VideoAsset do
  it { should belong_to :owner }
  it { should validate_presence_of :owner }
  it { should validate_presence_of :media_id }
  it { should validate_presence_of :type }
  it { should validate_presence_of :hosting_location_key }
end
