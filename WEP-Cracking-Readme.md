WEP is an old encryption , but its still used in some networks , therefore we will explain how to break it.

It uses an algorithm called RC4 where each packet is encrypted at the AP and is then decrypted at the client , WEP insures that each packet has a unique key stream by using a random 24-bit Initializing Vector (IV) , this IV is contained in the packets as plain text. 

The short IV means in a busy network we can collect more than two packets with the same IV, then we can use aircrack-ng to determine
the key stream and the WEP key using statistical attacks.

Conclusion: The more IV's that we collect the more likely for us to crack the key.

# Fake Authentication Attack
==========================================================

Before we can start injecting packets into the traffic , we have to authenticate our wifi card with the AP, because AP's ignore
any requests that come from devices that are not associated with the AP.

If this fake authentication was successful the value under the “AUTH” column in airodump-ng will change to “OPN”


# Method-1 : ARP Request Reply
===========================================================

In this method , after successfully associating with the target
AP , we will wait for an ARP packet , we will then capture this
packet and inject it into the traffic , this will force the AP to
generate a new ARP packet with a new IV , we capture this
new packet and inject into the traffic again , this process is
repeated until the number of IV's captured is sufficient enough
to crack the key.


# Method-2 : Korek chopchop
============================================================

In this method we will capture an ARP packet and attempt to guess its key stream and use it to forge a new packet (using packetforge-ng) ,then we can inject this new forged packet into the traffic to generate new IV's.


# Method - 3 : Fragmentation Attack
============================================================

The goal of this method is to obtain 1500 bytes of the PRGA (pseudo random generation algorithm) , this can be used to forge a new packet which can be injected into the traffic to generate new IV's
