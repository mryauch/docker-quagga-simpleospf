import subprocess
import ipaddress
cmd = 'ip route get 1.1.1.1'
output = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE).communicate()[0].decode()
lines = output.split('\n')
for line in lines:
  if '1.1.1.1' in line:
    int_name = line.split()[4]
    break

cmd = 'ip address show dev {}'.format(int_name)
output = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE).communicate()[0].decode()
lines = output.split('\n')
for line in lines:
  if 'inet' in line:
    ip_add = line.split()[1]
    break

ip_int = ipaddress.ip_interface(ip_add).network
ip = ip_add.split('/')[0]
lines = """hostname ospfd
password zebra
log stdout
!
interface {}
 ip ospf network point-to-multipoint
!
router ospf
 router-id {}
 redistribute connected
 network {} area 0.0.0.0
!
line vty
""".format(int_name,ip,ip_int)
with open("/etc/quagga/ospfd.conf",'w') as f:
  f.write(lines)
