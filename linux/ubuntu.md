===============================================================================
= Ubuntu Fresh Install Optimization
= Keith Hughitt
= last update: 2011/12/28
===============================================================================
    D. Firefox

        A. about:config (Speed improvements)

            network.http.pipelining > Make it True
            network.http.pipelining.maxrequests > Make it 8 or 10
            network.http.proxy.pipelining > Make it True
            network.dns.disableIPv6 > Make it True


#####################################
# OS Optimization
#####################################

    A. Turning off accesstime recording 

    B. Swap memory from hard disk to RAM

        # Check current swappiness
        sudo cat /proc/sys/vm/swappiness

        # Set to 10
        sudo sysctl -w vm.swappiness=10

        # To maintain after reboot
        sudo gedit /etc/sysctl.conf

            vm.swappiness=10

    C. Free up RAM by disabling some virtual consoles

    D. Enable concurrent booting

        sudo vim /etc/init.d/rc

        CONCURRENCY=none => CONCURRENCY=shell

    (http://www.zolved.com/synapse/view_content/28224/How_to_tune_your_Ubuntu_PC_for_faster_performance_)

#####################################
# Web Optimization
#####################################
    A. Gzip javascript/css
        # Edit /etc/apache2/mods-enabled/deflate.conf (or .htaccess)
        
            <IfModule mod_deflate.c>
                # these are known to be safe with MSIE 6
                AddOutputFilterByType DEFLATE text/html text/plain text/xml

                # everything else may cause problems with MSIE 6
                AddOutputFilterByType DEFLATE text/css
                AddOutputFilterByType DEFLATE application/x-javascript application/javascript application/ecmascript
                AddOutputFilterByType DEFLATE application/rss+xml
            </IfModule>
            
    B. Disable ETAGS
    
        1. Enable mod_headers (Same as creating a symlink in mods-enabled directory)
        
            sudo a2enmod headers
            
        2. Configure mod_headers
        
            # sudo vim /etc/apache2/mods-enabled/headers.conf
            
            Header unset ETag
            FileETag None
            
    C. Enable EXPIRES headers
    
        1. Enable mod_expires
        
            sudo a2enmod expires
            
        2. Configure mod_expires
        
            # sudo vim /etc/apache2/mods-enabled/expires.conf
            
<IfModule mod_expires.c>
        ExpiresActive On
        ExpiresByType image/x-icon "access plus 1 year"
        ExpiresByType image/png "access plus 3 months"
        ExpiresByType image/jpg "access plus 3 months"
        ExpiresByType image/gif "access plus 3 months"
        ExpiresByType image/jpeg "access plus 3 months"
        ExpiresByType video/ogg "access plus 1 month"
        ExpiresByType video/mpeg "access plus 1 month"
        ExpiresByType video/mp4 "access plus 1 month"
        ExpiresByType video/quicktime "access plus 1 month"
        ExpiresByType video/x-ms-wmv "access plus 1 month"
        ExpiresByType text/css "access plus 3 months"
        ExpiresByType text/javascript "access plus 3 months"
        ExpiresByType application/javascript "access plus 3 months"
</IfModule>
            
    D. Add JP2/JPX mimetypes
    
        # sudo vim /etc/apache2/mods-enabled/mime.conf

        AddType image/jp2 .jp2
        AddType video/mp4 .mp4
        AddType application/octet-stream .jpx
        
    E. Symbolic link support
    
        To avoid errors like "Symbolic link not allowed or link target not 
        accessible...", add "FollowSymLinks" to Apache config, and update 
        permissions:
        
            sudo chmod 755 /home
            chmod 755 "$HOME"
            chmod 755 $HOME/dir/
            chmod 755 $HOME/dir/dev/
            
        Alternatively, you can add the apache user (e.g. http) to the group 
        'users' and provide group access to each dir:
        
            sudo usermod -a -G users http
            chmod g+x /home/user
            chmod g+x /home/user/dir
            chmod -R g+x /home/user/dir/deny
            sudo rc.d restart httpd
        
        See: http://askubuntu.com/questions/36533/allowing-apache-access-to-a-subdirectory-in-a-home-directory-without-access-to-th 
        

#####################################
# Security
#####################################

    A. Apache
    
        1. Edit /etc/apache2/conf.d/security
        
            <Files *~>
                Order allow,deny
                Deny from all
            </Files>

            <Files *.py>
                Order allow,deny
                Deny from all
            </Files>

            <Files *.ini>
                Order allow,deny
                Deny from all
            </Files>
        
            ServerTokens Prod
            ServerSignature Off
            TraceEnable Off
            
        2. Disable directory listing
        
            (1) Edit /etc/apache2/sites-available/default (or /etc/apache2/httpd.conf on some systems) and change from:

                    <Directory /var/www/>
                        Options Indexes FollowSymLisnks MultiViews
                        AllowOverride None
                        Order allow,deny
                        allow from all
                    </Directory>

                to:
                
                   <Directory /var/www/>
                        Options FollowSymLinks MultiViews
                        AllowOverride Options Indexes
                        Order allow,deny
                        allow from all
                    </Directory>

                    
            (2) In the directory for which listing should be enabled, create an .htaccess file with the following:
            
                Options +Indexes
                IndexOptions +FancyIndexing
                
        3. Enable hiding of files at .htaccess level
        
            (1) Add "Limit" to the list of options that can be overridden for the server
            
                sudo vim /etc/apache2/sites-enabled/000-default
                
                <Directory /var/www/>
                    Options Indexes FollowSymLinks MultiViews
                    AllowOverride Options Indexes Limit
                    Order allow,deny
                    allow from all
                </Directory>
                
            (2) .htaccess file
            
                <Files *.ini>
                    Order allow,deny
                    Deny from all
                </Files>
                
        4. Enable mod_rewrite support using .htaccess files
        
            <Directory /var/www/>
		        Options FollowSymLinks MultiViews
		        AllowOverride Options Indexes Limit FileInfo
		        Order allow,deny
		        allow from all
	        </Directory>            
            

	5. Enable access to symlinked folders

		1. Add "FollowSymLinks" to options for web root (e.g. /var/www)
		2. Make www-data has exec privs for each ancestor directory of the sym-linked folder (e.g. chmod 751 /home/hughitt1/Dropbox)

	NOTE: You must make sure apache user (www-data) can access the path. To test this, switch to that user and try using "stat" on the folder, e.g.

		sudo su www-data
		stat /home/hughitt1/Dropbox/vso	        

	6. Perl Support
	
	    A. Perl CGI
        
            (1) Edit /etc/apache2/sites-available/default
            
                Options Indexes FollowSymLinks MultiViews +ExecCGI
                
            (2) Edit /etc/apache2/httpd.conf
            
                AddHandler cgi-script .pl
                
        B. Run Perl scripts from anywhere in /var/www

            1. Install ModPerl.
	        2. Edit httpd.conf and add the line "AddHandler cgi-script .pl" (it may be the only line in the file).
	        3. In the file /etc/apache2/sites-available/default, add the "+ExecCGI" param
	        4. Restart Apache (sudo /etc/init.d/apache2 restart)
            5. Test file (uses CGI module... doesn't need though):
            
                #!/usr/bin/perl -w
                use CGI;                             # load CGI routines
                $q = new CGI;                        # create new CGI object
                print $q->header,                    # create the HTTP header
                $q->start_html('hello world'), # start the HTML
                $q->h1('hello world'),         # level 1 header
                $q->end_html;                  # end the HTML
                    
            References:
            [1] http://www.thesitewizard.com/archive/addcgitoapache.shtml
            [2] http://perl.apache.org/
            [3] http://perl.apache.org/docs/2.0/user/intro/start_fast.html
            [4] http://httpd.apache.org/docs/1.3/misc/FAQ.html#CGIoutsideScriptAlias
            [5] http://perldoc.perl.org/CGI.html
                
    B. PHP
    
        1. Use -recommended configuration  (performance & security improvements)
        
            sudo cp /usr/share/doc/php5-common/examples/php.ini-recommended /etc/php5/apache2/php.ini
            
        2. Adjustments:
        
            max_execution_time =s 900
            error_reporting = E_ALL | E_STRICT
            error_log = syslog
            memory_limit = 4G
            default_socket_timeout = 120 # not sure if this is helpful

            ; for development only
            display_errors = On 
            
            ; Security (doh! needs to be on to support file_get_contents)
            ; allow_url_fopen = Off
            
            ; NOTE: html_errors has to be enabled to see nice output
            
            [xdebug]
            ;xdebug.profiler_enable=On
            xdebug.show_local_vars=On
            xdebug.dump_globals=On
            xdebug.collect_params=4
            xdebug.profiler_enable_trigger=On
            xdebug.dump.POST=*
            xdebug.dump.GET=*
            xdebug.remote_enable=On
            xdebug.remote_host="localhost"
            xdebug.remote_port=9000
            xdebug.remote_handler="dbgp"
    
    C. MySQL
    
        sudo apt-get install mysql-server-5.1 mysql-client-5.1 mysql-gui-tools-common

        # Set password for root user
        mysqladmin -u root password 'new-password' 
    
        # Rename root user
        mysql -uroot -p -e "UPDATE mysql.user SET user = 'new_user' WHERE user = 'root';"
        mysql -uroot -p -e "flush privileges;"
        
        # Remove anonymous user, test db
        mysql -u root -p
        
        mysql> DROP DATABASE test;
        mysql> DELETE FROM mysql.user WHERE user = '';
        mysql> FLUSH PRIVILEGES;

    D. Arno's Firewall

        1. Install
        
            sudo apt-get install arno-iptables-firewall

        2. Command-line setup tool will be launched. Select "Use debconf", and then model the following questions after the below configuration:

            /etc/arno-iptables-firewall/debconf.cfg

            DC_EXT_IF="eth0"
            DC_EXT_IF_DHCP_IP=1
            DC_OPEN_TCP="22"           // or 22 80 8090
            DC_OPEN_UDP=""
            DC_INT_IF=""
            DC_NAT=0
            DC_INTERNAL_NET=""
            DC_NAT_INTERNAL_NET=""
            DC_OPEN_ICMP=1

        3. Edit/create /etc/arno-iptables-firewall/custom-rules

            HOST_OPEN_TCP="server.gov>80 server2.gov>80 etc"

    E. OpenSSH

        1. Install

            sudo apt-get install openssh-server openssh-client

        2. gedit /etc/ssh/sshd_config, use the following settings:
        
            LogLevel VERBOSE
            LoginGraceTime 60
            Protocol 2
            PermitRootLogin no
            Port 3729
            MaxStartups 5
            Banner /etc/issue.net
            
    F. /etc/issue.net

    G. TCP Wrappers
    
        /etc/hosts.allow
        
            ALL : 198.118.248.
        
        /etc/hosts.deny
        
            ALL : ALL
            
    H. /etc/login.defs
    
        PASS_MAX_DAYS    180
        PASS_MIN_DAYS    0
        PASS_WARN_AGE    28
        
    I. NTP
    
        1. sudo apt-get install ntp
        
        2. gedit /etc/ntp.conf
            server xxx
            server yyy
        
    J. Anti-virus
    
        sudo apt-get install clamav

    K. Screensaver lock
    
        alt + f2 -> "gnome-screensaver-preferences"
        
        5 mins
        
        [x] activate when idle
        [x] lock screen
        
    L. Disable Multicast DNS
    
        sudo apt-get remove libnss-mdns telepathy-salut avahi-daemon avahi-autoipd libavahi-core6
        
        (To disable temporarily, use "sudo update-rc.d -f avahi-daemon remove")
        
    M. Account Locking
    
        # Add the following lines to either /etc/pam.d/system-auth  or  /etc/pam.d/login
        #auth    required   /lib/security/$ISA/pam_tally.so onerr=fail no_magic_root
        #account required   /lib/security/$ISA/pam_tally.so per_user deny=6 no_magic_root reset
        auth    required   pam_tally.so onerr=fail no_magic_root
        account required   pam_tally.so per_user deny=6 no_magic_root reset
        
    N. Restrict Cron/at
    
        1. touch /etc/cron.allow /etc/cron.deny /etc/at.allow /etc/at.deny
        2. Add one line per user-name to each .allow file for root and any other users which should have access.
       
 
###########################################################
# More Security Tips
########################################################### 

A. Block ICMP

    echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
    
B. Detection login attempts

    less /var/log/auth
    
C. DenyHosts

    sudo apt-get install denyhosts
    
    # /etc/denyhosts.conf
    DENY_THRESHOLD_INVALID = 2
    DENY_THRESHOLD_VALID = 3
    
    # see /var/log/denyhosts
    
D. Firestarter (UFW/Arno's IPTables alternative)
        
###########################################################
# Trouble-shooting
###########################################################

A. Specifying search domain for auto connection

    1. Edit /etc/resolv.conf

        # Generated by NetworkManager
        search server.gov
        nameserver xxx.xxx.xxx.xxx
        nameserver xxx.xxx.xxx.xxx

        
B. Network performance

    1. sudo iwconfig wlan0 / sudo ethtool -S eth0
    
        tx_late_collsion & rx_late_collision = Late colisions (network cables too long?)
        tx_crc_errors    & rx_crc_errors     = CRC errors (Physical problem with cables, or with nic?)
        rx_frame_align_error                 = Frame align errors (electrical interference along data path?)

