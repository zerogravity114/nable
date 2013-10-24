# Define: nable::netinstall.pp
# 
define nable::netinstall (
  $url,
  $extracted_dir,
  $destination_dir,
  $owner = "root",
  $group = "root",
  $work_dir = "/var/tmp",
  $path = '/bin:/sbin:/usr/bin:/usr/sbin',
  $extract_command = "tar -zxvf",
  $preextract_command = "",
  $postextract_command = "",
  $source_filename = "nagent-rhel5.1_64.tar.gz",
) {


  if $preextract_command {
    exec  {
      "PreExtract $source_filename":
        command     => $preextract_command,
        path        => $path,
        before      => Exec["Extract $source_filename"],
        refreshonly => true,
    }
  }

  exec {
    "Retrieve $url":
      cwd     => "$work_dir",
      path    => $path,
      command => "/usr/bin/wget $url",
      creates => "$work_dir/$source_filename",
      timeout => 3600,
  }

  exec {
    "Extract $source_filename":
      path    => $path,
      command => "mkdir -p $destination_dir && cd $destination_dir && $extract_command $work_dir/$source_filename",
      # unless  => "find $destination_dir | grep $extracted_dir",
      creates => "${destination_dir}/${extracted_dir}",
      require => Exec["Retrieve $url"],
  }

  if $postextract_command {
    exec {
      "PostExtract $source_filename":
        path        => $path,
        command     => $postextract_command,
        cwd         => "$destination_dir/$extracted_dir",
        subscribe   => Exec["Extract $source_filename"],
        refreshonly => true,
        timeout     => 3600,
        require     => Exec["Extract $source_filename"],
    }
  }
}
