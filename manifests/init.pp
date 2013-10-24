# Install N-Able from its tarball, only works on RHEL5/6 or Centos 5/6
class nable {

  $nable_act_key,

# Install tgz from source url
nable::netinstall { nagent:
  url                 => "https://uptime.xantrion.com/download/9.1.0.564/rhel5.1_64/N-central/nagent-rhel5.1_64.tar.gz",
  extracted_dir       => "nagent-rhel5.1_64",
  destination_dir     => "/var/tmp",
  postextract_command => "$destination_dir/$extracted_dir/install.sh -k $nable_act_key"
  creates             => "/etc/nagent.conf"
}




}
