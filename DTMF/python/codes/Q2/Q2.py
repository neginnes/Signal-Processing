
import pyaudio
import numpy as np
from scipy import signal
from scipy import io
from pymatreader import read_mat
import operator
#import matplotlib.pyplot as plt
#from scipy.fftpack import fft


def freq_detector(wav_arr):
    out1 = []
    out2 = []
    for fi in range(8):
        if (fi == 7 ) :
            freq = 697
        elif (fi == 6 ) :
            freq = 770
        elif (fi == 5 ) :
            freq = 852
        elif (fi == 4 ) :
            freq = 941
        elif (fi == 3 ) :
            freq = 1209
        elif (fi == 2 ) :
            freq = 1336
        elif (fi == 1 ) :
            freq = 1477
        elif (fi == 0 ) :
            freq = 1633
        wav = wav_arr[fi]
        wav = wav/max(wav)
        #print(sum(wav**2)/len(wav) ," energy ")
        if (sum(wav**2)/len(wav) >= 0.25) and (fi >= 4):
            out2.append((freq,sum(wav**2)/len(wav),fi))
        elif (sum(wav**2)/len(wav) >= 0.25) and (fi < 4):
            out1.append((freq,sum(wav**2)/len(wav),fi))
    return out1 , out2   

def decode (freq_arr1 , freq_arr2 ):
    freq_arr1.sort(key = operator.itemgetter(1))
    freq_arr2.sort(key = operator.itemgetter(1))
    keys = []
    if(len(freq_arr1)>0) and (len(freq_arr2)>0):
        if ((freq_arr1[len(freq_arr1)-1][0],freq_arr2[len(freq_arr2)-1][0]) in freq2key_dict.keys()):
            keys.append(freq2key_dict[(freq_arr1[len(freq_arr1)-1][0],freq_arr2[len(freq_arr2)-1][0])])
#    print(freq_arr1 , freq_arr2 ,"freq ")
    return (keys)


freq2key_dict = {
  (697,1209): "1",
  (697,1336): "2",
  (697,1477): "3",
  (697,1633): "A",
  (770,1209): "4",
  (770,1336): "5",
  (770,1477): "6",
  (770,1633): "B",
  (852,1209): "7",
  (852,1336): "8",
  (852,1477): "9",
  (852,1633): "C",
  (941,1209): "*",
  (941,1336): "0",
  (941,1477): "#",
  (941,1633): "D",
  (1209,697): "1",
  (1336,697): "2",
  (1477,697): "3",
  (1633,697): "A",
  (1209,770): "4",
  (1336,770): "5",
  (1477,770): "6",
  (1633,770): "B",
  (1209,852): "7",
  (1336,852): "8",
  (1477,852): "9",
  (1633,852): "C",
  (1209,941): "*",
  (1336,941): "0",
  (1477,941): "#",
  (1633,941): "D"
}


def signal_processing(x , previous_x): 
    if (len(previous_x)>0):
        X = np.zeros(2*CHUNK)
        X[0:CHUNK] = previous_x
        X[CHUNK:CHUNK*2] = x.T
    else:
        X = np.zeros(CHUNK)
        X[0:CHUNK] =x.T
    
    filtered_X1 = signal.lfilter(filter_1633, 1 , X)
    filtered_X2 = signal.lfilter(filter_1477, 1 , X)
    filtered_X3 = signal.lfilter(filter_1336, 1 , X)
    filtered_X4 = signal.lfilter(filter_1209, 1 , X)
    filtered_X5 = signal.lfilter(filter_941, 1 , X)
    filtered_X6 = signal.lfilter(filter_852, 1 , X)
    filtered_X7 = signal.lfilter(filter_770, 1 , X)
    filtered_X8 = signal.lfilter(filter_697, 1 , X)

    
    filtered_X11 = filtered_X1[len(filtered_X1)-CHUNK:]
    filtered_X21 = filtered_X2[len(filtered_X1)-CHUNK:]
    filtered_X31 = filtered_X3[len(filtered_X1)-CHUNK:]
    filtered_X41 = filtered_X4[len(filtered_X1)-CHUNK:]
    filtered_X51 = filtered_X5[len(filtered_X1)-CHUNK:]
    filtered_X61 = filtered_X6[len(filtered_X1)-CHUNK:]
    filtered_X71 = filtered_X7[len(filtered_X1)-CHUNK:]
    filtered_X81 = filtered_X8[len(filtered_X1)-CHUNK:]
    
    filtered_X = [filtered_X11 , filtered_X21 , filtered_X31  , filtered_X41  , filtered_X51  , filtered_X61 , filtered_X71  , filtered_X81 ]  

    freq_arr1 , freq_arr2 = freq_detector(filtered_X)
    pressed_keys = decode(freq_arr1 , freq_arr2)
    
    print("OUT: ",pressed_keys) 
       
    
CHUNK = 1024*4
WIDTH = 2
CHANNELS = 1
RATE = 44100
fs = RATE


band = [692, 702]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000      # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_697.mat', {'filter_697': taps })

band = [765 , 775]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_770.mat', {'filter_770': taps })


band = [847 , 857]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_852.mat', {'filter_852': taps })

band = [936, 946]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000      # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_941.mat', {'filter_941': taps })

band = [1204 , 1214]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1209.mat', {'filter_1209': taps })

band = [1331 , 1341]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000      # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1336.mat', {'filter_1336': taps })

band = [1472 , 1482]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1477.mat', {'filter_1477': taps })

band = [1628 , 1638]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 1000       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1633.mat', {'filter_1633': taps })

filter_697 = list(read_mat('filter_697.mat').items())[3][1]
filter_770 = list(read_mat('filter_770.mat').items())[3][1]
filter_852 = list(read_mat('filter_852.mat').items())[3][1]
filter_941 = list(read_mat('filter_941.mat').items())[3][1]
filter_1209 = list(read_mat('filter_1209.mat').items())[3][1]
filter_1336 = list(read_mat('filter_1336.mat').items())[3][1]
filter_1477 = list(read_mat('filter_1477.mat').items())[3][1]
filter_1633 = list(read_mat('filter_1633.mat').items())[3][1]


#RECORD_SECONDS = 5

p = pyaudio.PyAudio()

stream = p.open(format=p.get_format_from_width(WIDTH),
                channels=CHANNELS,
                rate=RATE,
                input=True,
                output=True,
                frames_per_buffer=CHUNK)
#c = int(CHUNK/2)
#fig, ax = plt.subplots()
#line, = ax.plot(np.random.randn(c))
#fig.canvas.draw()
#plt.show(block=False)
#ax.draw_artist(ax.patch)
#num_plots = 0 
#plt.ylim(0, 10000);

print("* recording")
previous_x = []
try:
    while True :
        data = stream.read(CHUNK)
        x = np.frombuffer(data, dtype='<i2').reshape(-1, CHANNELS) 
        signal_processing(x,previous_x)
        previous_x = x.T
#        sgnl_fur = abs(fft(x)[0:c])
#        line.set_ydata(sgnl_fur)
#        ax.draw_artist(ax.patch)
#        ax.draw_artist(line)
#        fig.canvas.blit(ax.bbox)
#        #fig.canvas.update()
#        fig.canvas.flush_events()
#        num_plots += 1 
        

except KeyboardInterrupt:
    pass

print("* done")
stream.stop_stream()
stream.close()
p.terminate()