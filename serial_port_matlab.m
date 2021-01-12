clear all; close all; clc;
s = serialport('COM4', 57600); flush(s);
stopTime = 15;
rollAngle = single(0.0); pitchAngle = single(0.0); time = 0;
i = 0; % package number
while ( time(end) < stopTime )
    if (read(s, 1, 'uint8') == 'h')
        i = i + 1;
        rollAngle(1,i) = read(s, 1, 'single');
        pitchAngle(1,i) = read(s, 1, 'single');
        time(i) = double(read(s, 1, 'uint32')) / 1000;
        fprintf('paket = %i  roll = %.2f  pitch = %.2f  zaman = %.2f\n', ...
            i, rollAngle(1,i), pitchAngle(1,i), time(i));
    end
end
delete(s); clear s;
%% plot the logged angles
figure(1);
subplot(1,2,1);
plot(time, rollAngle, 'k-');
xlabel('time (s)'); ylabel('roll angle (degrees)');
grid on;
subplot(1,2,2);
plot(time, pitchAngle, 'k-');
xlabel('time (s)'); ylabel('pitch angle (degrees)');
grid on;