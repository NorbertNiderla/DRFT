import socket
import time
import os

time_now = time.strftime("%Y-%m-%d_%H-%M")
f = open(os.path.join(os.getcwd(), 'DRFT_ride_data'+time_now+'.csv'), 'w+')
f.close()

last_ip_dot = ['1', '2']  # last parts of IP's of boards

curr = 0
last = 0
file = os.path.join(os.getcwd(), 'DRFT_ride_data'+time_now+'.csv')
f = open(file, 'a+')
f.write('AcX,AcY,AcZ,GyX,GyY,GyZ,\n')
f.close()
while True:

    for dot in last_ip_dot:
        curr = int(dot)
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.connect(('192.168.4.'+dot, 8888))

        data = s.recv(32)
        if len(data) <= 0:
            s.close()
            continue
        if curr == last:
            continue
        with open(file, 'a+') as f:
            f.write((data.decode('utf-8')+' ').replace(' ', ','))
            if curr == 2:
                f.write('\n')
            f.close()
        last = curr
        s.close()


