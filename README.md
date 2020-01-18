USEFUL URL:

https://guides.rubyonrails.org/active_storage_overview.html

# Active Storage
## And Aliyun OSS
---
## Active Storage
### One Gem To Rule Them All
---
## Think about Driving A Car
![](http://img0.imgtn.bdimg.com/it/u=1888338670,2580492580&fm=214&gp=0.jpg)<!-- .element class="img-left" -->

![](http://img1.imgtn.bdimg.com/it/u=589362298,513569457&fm=26&gp=0.jpg)<!-- .element class="img-right" -->
---
## It doesn't matter what you drive.
---
## If you know how to drive.
# You can drive.
---
## Active Storage Installation

- Setup Migrations
- Find Adaptor GEM
- Add Configurations
---
## Active Storage Installation
### Setup Migrations

```
rails active_storage:install
```
---
## Active Storage Installation
### Find Adaptor GEM

In Gemfile add:

```
# Add activestorage gem for your bucket provider.
# Most popular buckets have available gems.
gem 'activestorage-aliyun'
```
---
## Active Storage Installation
### Add Configurations (1)

Remember, buckets cost money!
So you want to make sure everything is **SUPER SECURE**.

Add your credentials in a heavily encrypted file by using the following command:

`EDITOR=nano rails credentials:edit`

```
# Note: endpoint depends on the bucket location you choose.
aliyun:
    access_key_id: some_access_key
    access_key_secret: some_access_key_secret
    bucket: bucket_name
    endpoint: https://oss-cn-hangzhou.aliyuncs.com
```
---
## Active Storage Installation
### Add Configurations (2)

In `/config/storage.yml` add:

```
aliyun:
  service: Aliyun
  access_key_id: <%= Rails.application.credentials.dig(:aliyun, :access_key_id) %>
  access_key_secret: <%= Rails.application.credentials.dig(:aliyun, :access_key_secret) %>
  bucket: <%= Rails.application.credentials.dig(:aliyun, :bucket) %>
  endpoint: <%= Rails.application.credentials.dig(:aliyun, :endpoint) %>
  mode: "private"
  # path prefix (optional), default: /
  # path: "/"

```
In `/config/environments/________.rb` change:
```
# config.active_storage.service = :local
config.active_storage.service = :aliyun
```

---
Note the `Rails.application.credentials.dig()`

This grabs data from the encrypted credentials file, as long as you have the correct value saved in the hidden file: `/config/master.key`

(`master.key` is automatically created w/ rails project)
---
# Installation Finished
---
## Active Storage
### Usage Guide
---
## Setup Model To Receive Attachments
### Just add one line of code!
```
class User < ApplicationRecord
  # for one attachment
  has_one_attached :avatar

  # or for many attachments
  has_many_attached :photos
end
```
---
## Attaching files
In Rails Console:
```
> f = File.open('/some-path/to/avatar.png')
> u = User.first
> u.avatar.attach(io: f, filename: 'avatar.png')

```
In Controller:
```
def update
  # For file attached to has_one_attached
  @user.avatar.attach(params[:avatar])

  # For Array of images to has_many_attached
  params[:photos].each do |photo|
    @user.photos.attach(photo)
  end
end
```
---
## Removing Files

```
# for has_one_attached
@user.avatar.purge

@ for has_many_attached
@user.photos[0].purge
```
