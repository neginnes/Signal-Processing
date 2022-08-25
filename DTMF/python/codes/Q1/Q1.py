# -*- coding: utf-8 -*-
"""
Created on Fri May 28 12:45:05 2021

@author: negin
"""
import wave
from scipy import signal
from scipy import io
#import matplotlib.pyplot as plt
import numpy as np
from pymatreader import read_mat
import operator



def press_start_time(wav_arr,fs):
    out = []
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
        l = len(wav)
        wav = wav/max(wav)
        

        n = 0
        while(n < l):
            if (wav[n]**2 < 0.1):
                #print("lsdjklsd")
                cnt = 0 
                while(wav[n + cnt]**2 < 0.1):
                    #print("inh")
                    cnt = cnt + 1
                    if(n + cnt >= l):
                        break       
                t = (cnt - 1) / fs 
                if( t > 0.1 ):
                    out.append((n + cnt-1 , freq))
                if(cnt>0):
                    n = n + cnt-1
            n = n + 1 
        del out[len(out)-1]
#    print(out , len(wav))
    return out    


def decode (arr_tuple):
    arr_tuple.sort(key = operator.itemgetter(0))
    keys = []
    #print(arr_tuple,"kjkhfygkhjokplpkjhjhfg" , len(arr_tuple))
    for i in range(len(arr_tuple)):
        j = 2*i
        if (j < len(arr_tuple)):
            keys.append(freq2key_dict[(arr_tuple[j][1],arr_tuple[j + 1][1])])
        
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


# making filters and saving as mat file 

fs = 8192       # Sample rate, Hz

band = [692, 702]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500      # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_697.mat', {'filter_697': taps })

band = [765 , 775]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_770.mat', {'filter_770': taps })


band = [847 , 857]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_852.mat', {'filter_852': taps })

band = [936, 946]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_941.mat', {'filter_941': taps })

band = [1204 , 1214]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1209.mat', {'filter_1209': taps })

band = [1331 , 1341]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1336.mat', {'filter_1336': taps })

band = [1472 , 1482]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1477.mat', {'filter_1477': taps })

band = [1628 , 1638]  # Desired pass band, Hz
trans_width = 50    # Width of transition from pass band to stop band, Hz
numtaps = 500       # Size of the FIR filter.
edges = [0, band[0] - trans_width, band[0], band[1],band[1] + trans_width, 0.5*fs]
taps = signal.remez(numtaps, edges, [0, 1, 0], Hz=fs)
io.savemat('filter_1633.mat', {'filter_1633': taps })



# loading filters and wav files 

filter_697 = list(read_mat('filter_697.mat').items())[3][1]
filter_770 = list(read_mat('filter_770.mat').items())[3][1]
filter_852 = list(read_mat('filter_852.mat').items())[3][1]
filter_941 = list(read_mat('filter_941.mat').items())[3][1]
filter_1209 = list(read_mat('filter_1209.mat').items())[3][1]
filter_1336 = list(read_mat('filter_1336.mat').items())[3][1]
filter_1477 = list(read_mat('filter_1477.mat').items())[3][1]
filter_1633 = list(read_mat('filter_1633.mat').items())[3][1]

w1 = wave.open('DialedSequence_SNR00dB.wav', 'r')
w_noisy00 = w1.readframes(-1)
w_noisy00 = np.fromstring(w_noisy00, 'Int16')
w2 = wave.open('DialedSequence_SNR10dB.wav', 'r')
w_noisy10 = w2.readframes(-1)
w_noisy10 = np.fromstring(w_noisy10, 'Int16')
w3 = wave.open('DialedSequence_SNR20dB.wav', 'r')
w_noisy20 = w3.readframes(-1)
w_noisy20 = np.fromstring(w_noisy20, 'Int16')
w4 = wave.open('DialedSequence_SNR30dB.wav', 'r')
w_noisy30 = w4.readframes(-1)
w_noisy30 = np.fromstring(w_noisy30, 'Int16')
w5 = wave.open('DialedSequence_NoNoise.wav', 'r')
w_nonoise  = w5.readframes(-1)
w_nonoise  = np.fromstring(w_nonoise , 'Int16')

#print(type(w_noisy00),'kghhj;k')

# filtering the wav files

filtered_w_noisy00 = [signal.filtfilt(filter_1633, 1 , w_noisy00) , signal.filtfilt(filter_1477, 1 ,w_noisy00) , signal.filtfilt(filter_1336, 1 , w_noisy00) , signal.filtfilt(filter_1209, 1 , w_noisy00) , signal.filtfilt(filter_941, 1 , w_noisy00) , signal.filtfilt(filter_852, 1 , w_noisy00) , signal.filtfilt(filter_770, 1 , w_noisy00) , signal.filtfilt(filter_697, 1 , w_noisy00)]
filtered_w_noisy10 = [signal.filtfilt(filter_1633, 1 , w_noisy10) , signal.filtfilt(filter_1477, 1 ,w_noisy10) , signal.filtfilt(filter_1336, 1 , w_noisy10) , signal.filtfilt(filter_1209, 1 , w_noisy10) , signal.filtfilt(filter_941, 1 , w_noisy10) , signal.filtfilt(filter_852, 1 , w_noisy10) , signal.filtfilt(filter_770, 1 , w_noisy10) , signal.filtfilt(filter_697, 1 , w_noisy10) ]
filtered_w_noisy20 = [signal.filtfilt(filter_1633, 1 , w_noisy20) , signal.filtfilt(filter_1477, 1 ,w_noisy20) , signal.filtfilt(filter_1336, 1 , w_noisy20) , signal.filtfilt(filter_1209, 1 , w_noisy20) , signal.filtfilt(filter_941, 1 , w_noisy20) , signal.filtfilt(filter_852, 1 , w_noisy20) , signal.filtfilt(filter_770, 1 , w_noisy20) , signal.filtfilt(filter_697, 1 , w_noisy20) ]
filtered_w_noisy30 = [signal.filtfilt(filter_1633, 1 , w_noisy30) , signal.filtfilt(filter_1477, 1 ,w_noisy30) , signal.filtfilt(filter_1336, 1 , w_noisy30) , signal.filtfilt(filter_1209, 1 , w_noisy30) , signal.filtfilt(filter_941, 1 , w_noisy30) , signal.filtfilt(filter_852, 1 , w_noisy30) , signal.filtfilt(filter_770, 1 , w_noisy30) , signal.filtfilt(filter_697, 1 , w_noisy30) ]
filtered_w_nonoise = [signal.filtfilt(filter_1633, 1 , w_nonoise) , signal.filtfilt(filter_1477, 1 ,w_nonoise) , signal.filtfilt(filter_1336, 1 , w_nonoise) , signal.filtfilt(filter_1209, 1 , w_nonoise) , signal.filtfilt(filter_941, 1 , w_nonoise) , signal.filtfilt(filter_852, 1 , w_nonoise) , signal.filtfilt(filter_770, 1 , w_nonoise) , signal.filtfilt(filter_697, 1 , w_nonoise) ]



pressed_keys1 = decode(press_start_time(filtered_w_noisy00,fs))
pressed_keys2 = decode(press_start_time(filtered_w_noisy10,fs))
pressed_keys3 = decode(press_start_time(filtered_w_noisy20,fs))
pressed_keys4 = decode(press_start_time(filtered_w_noisy30,fs))
pressed_keys5 = decode(press_start_time(filtered_w_nonoise,fs))


print("wav_noisy00 = ",pressed_keys1)    
print("wav_noisy10 = ",pressed_keys2) 
print("wav_noisy20 = ",pressed_keys3)
print("wav_noisy30 = ",pressed_keys4)
print("wav_nonoise = ",pressed_keys5)
 
 



