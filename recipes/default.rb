android_sdk_tar_filename = File.basename(node['android_sdk']['download_url'])
android_sdk_tar_filepath = "#{Chef::Config['file_cache_path']}/#{android_sdk_tar_filename}"
android_sdk_extract_path = "#{Chef::Config['file_cache_path']}/android_sdk/#{node['android_sdk']['checksum']}"
android_sdk_install_path = "#{node['android_sdk']['install_path']}/#{node['android_sdk']['install_dir']}"

include_recipe "ark"
include_recipe "java-crate"

ark node['android_sdk']['install_dir'] do
  url node['android_sdk']['download_url']
  path node['android_sdk']['install_path']
  checksum node['android_sdk']['checksum']
  owner node['uncrate']['user']
  group node['uncrate']['user']
  mode 0755
  action :put
end

template "#{node['uncrate']['envdir']}/androidsdk.sh" do
  source "androidsdkenv.sh.erb"
  mode "0755"
end

if node['android_sdk']['include_tools']
  package = 'tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
    user node['uncrate']['user']
    group node['uncrate']['user']
  end
end

if node['android_sdk']['include_platform_tools']
  package = 'platform-tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
    user node['uncrate']['user']
    group node['uncrate']['user']
  end
end

if node['android_sdk']['include_build_tools']
  package = 'build-tools'
  execute "Install android package #{package}" do
    command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
    user node['uncrate']['user']
    group node['uncrate']['user']
  end
end

# TODO: Create a LWRP for installing android packages
# android_platform "android platform #{android_version}" do
#   action :install
# end

versions = node['android_sdk']['versions']
if node['android_sdk']['include_platform']
  versions.each do |android_version|
    package = "android-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end

if node['android_sdk']['include_add_ons']
  versions.each do |android_version|
    package = "addon-google_apis-google-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end

if node['android_sdk']['include_docs']
  versions.each do |android_version|
    package = "doc-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end

if node['android_sdk']['include_source']
  versions.each do |android_version|
    package = "source-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end

if node['android_sdk']['include_system_image']
  versions.each do |android_version|
    package = "sysimg-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end

if node['android_sdk']['include_sample']
  versions.each do |android_version|
    package = "sample-#{android_version}"
    execute "Install android package #{package}" do
      command "echo \"y\" | #{android_sdk_install_path}/tools/android update sdk -u --all --filter #{package}"
      user node['uncrate']['user']
      group node['uncrate']['user']
    end
  end
end
