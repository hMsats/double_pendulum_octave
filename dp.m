  clear all

% Set various parameters

  energy_loss_new=0.01;

  N=4; % /* number of equations to solve */
  G=9.8; % /* gravitational acceleration in m/s^2 */
  L1=1; % /* length of pendulum 1 in m */
  L2=0.6; % /* length of pendulum 2 in m */
  M1=1; % /* mass of pendulum 1 in kg */
  M2=1; % /* mass of pendulum 2 in kg */

  TH10 = 120;
  W10 = 0;
  TH20 = 80;
  W20 = 0;

  delt=0.005;

  th1 = TH10*pi/180;
  w1 = W10*pi/180;
  th2 = TH20*pi/180;
  w2 = W20*pi/180; 

  figure(1);
  set(1,'DefaultLineLineWidth',3);

  y1=-L1*cos(th1);
  y2=y1-L2*cos(th2);
 
  v2=w1*w1*L1*L1+w2*w2*L2*L2+2*w1*w2*L1*L2*cos(th1-th2);
  energy0=M1*G*y1+M2*G*y2+0.5*M1*w1*w1*L1*L1+0.5*M2*v2;

  pi2=2*pi;
  m=1;
  i=1;
  t=0;
  mmax=floor(0.1/delt);

  delw=0;
  Tdetermine=1;
  fprintf(1,'Busy determining the time delay (will take about %d seconds)\n',Tdetermine);
  fflush(1);
  th1aux=th1;
  th2aux=th2;

% Determine the time delay necessary to show the pendulum in realtime.
% Run the program and compare the simulated time to the real time (tic/toc).
% Use that to determine the delay
  for nn=1:Tdetermine
    tic;
    t=0;
    m=1;
    nplot=0;
    while t<1

      t = t + delt;

      yin(1) = th1;
      yin(2) = w1;
      yin(3) = th2;
      yin(4) = w2;

      yout=runge_kutta(t, yin, delt,N,G,L1,L2,M1,M2);

      w1aux = yout(2);
      w2aux = yout(4);
      if (th1 < -pi)
        yout(1)=yout(1)+pi2;
      end
      if (th1 > pi)
        yout(1)=yout(1)-pi2;
      end
      if (th2 < -pi)
        yout(3)=yout(3)+pi2;
      end
      if (th2 > pi)
        yout(3)=yout(3)-pi2;
      end

      aux = yout(1);
      aux = yout(2);
      aux = yout(3);
      aux = yout(4);

      if (m==mmax)
        %pause
        nplot=nplot+1;
        m=1;
        if (t>=1) && (nn==Tdetermine)
          th1aux=th1;
          th2aux=th2;
        else
          th1aux=-th1aux;
          th2aux=-th2aux;
        end
   
        x1=L1*sin(th1aux);
        y1=-L1*cos(th1aux);

        x2=x1+L2*sin(th2aux);
        y2=y1-L2*cos(th2aux);

        hold off;
        plot([0 x1],[0 y1],'b*-');
        hold on;
        plot([x1 x2],[y1 y2],'r*-');
        hold off;
        axis([-(L1+L2) (L1+L2) -(L1+L2) (L1+L2)]);
        grid on;
        treal=0;
        verhouding=floor(10*1)/10;
        if verhouding == 1
          title(['      ' num2str(floor(0)) ' (' num2str(verhouding) '.0)']);
        else
          title(['      ' num2str(floor(0)) ' (' num2str(verhouding) ')']);
        end
        drawnow;
        pause(delw);
        v2=w1*w1*L1*L1+w2*w2*L2*L2+2*w1*w2*L1*L2*cos(th1aux-th2aux);
        energy=M1*G*y1+M2*G*y2+0.5*M1*w1*w1*L1*L1+0.5*M2*v2;
        energy_loss=(energy0-energy)/energy0*100;
        if (abs(energy_loss) > 1)
        end
      else
        m=m+1;
      end
    end
    treal=toc;
    delw=delw+(t-treal)/nplot;
  end
  if delw <0
    delw=0;
    fprintf(1,'The computer is too slow for given values, time delay set to zero\n');
    fflush(1);
  end

  t=0;
  m=1;
  treal=0;

% Wait for key press
  fprintf(1,'Press an arbitrary key to start (after 3 seconds): ');
  fflush(1);
  pause; fprintf(1,'\n');
  fflush(1);
  pause(3);
  tic;
  trealbegin=treal;

% Start the simulation
  n=0;
  while(1)
    t = t + delt;

    yin(1) = th1;
    yin(2) = w1;
    yin(3) = th2;
    yin(4) = w2;
    yout=runge_kutta(t, yin, delt,N,G,L1,L2,M1,M2);

    w1 = yout(2);
    w2 = yout(4);
    if (th1 < -pi)
      yout(1)=yout(1)+pi2;
    end
    if (th1 > pi)
      yout(1)=yout(1)-pi2;
    end
    if (th2 < -pi)
      yout(3)=yout(3)+pi2;
    end
    if (th2 > pi)
      yout(3)=yout(3)-pi2;
    end

    th1 = yout(1);
    w1 = yout(2);
    th2 = yout(3);
    w2 = yout(4);

    if (m==mmax)
      m=1;
      x1=L1*sin(yout(1));
      y1=-L1*cos(yout(1));

      x2=x1+L2*sin(yout(3));
      y2=y1-L2*cos(yout(3));

      hold off;
      plot([0 x1],[0 y1],'b*-');
      hold on;
      plot([x1 x2],[y1 y2],'r*-');
      hold off;
      axis([-(L1+L2) (L1+L2) -(L1+L2) (L1+L2)]);
      grid on;

      n=n+1;
      pos_array(n,1)=x2;
      pos_array(n,2)=y2;

      treal=trealbegin+toc;
      verhouding=floor(10*treal/t)/10;
      if verhouding == 1
        title(['      ' num2str(floor(t)) ' (' num2str(verhouding) '.0)']);
      else
        title(['      ' num2str(floor(t)) ' (' num2str(verhouding) ')']);
      end
      drawnow;
      pause(delw);

      v2=w1*w1*L1*L1+w2*w2*L2*L2+2*w1*w2*L1*L2*cos(th1-th2);
      energy=M1*G*y1+M2*G*y2+0.5*M1*w1*w1*L1*L1+0.5*M2*v2;
      energy_loss=(energy0-energy)/energy0*100;
      if (abs(energy_loss) > energy_loss_new)
        fprintf(1,'\nThe energy loss equals: %f procent\n\n',energy_loss);
        fflush(1);
        toc
        energy_loss_new=energy_loss+0.01;
        %return;
      end
    else
      m=m+1;
    end
  end
