switch "#{node[:platform][:machine]}"
  case "x86_64"
    default['gtest']['lib_dir'] = "/usr/local/lib64"
  case "i386"
    default['gtest']['lib_dir'] = "/usr/local/lib"
  end
end

default['gtest']['include_dir'] = "/usr/local/include"
default['gtest']['download_url'] = "https://googlemock.googlecode.com/files"
default['gtest']['version'] = "1.7.0"