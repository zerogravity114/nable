include nable

nable::netinstall { 'nagent':
   url                       => "https://uptime.xantrion.com/download/9.1.0.564/rhel5.1_64/N-central/nagent-rhel5.1_64.tar.gz",
     extracted_dir           => "nagent-rhel5.1_64",
       destination_dir       => "/var/tmp",
         postextract_command => "$destination_dir/$extracted_dir/install.sh -k aHR0cHM6Ly91cHRpbWUueGFudHJpb24uY29tOjQ0M3w2MTc3OTgwODd8MXww"
           creates           => "/etc/nagent.conf"

}
