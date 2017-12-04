% v_m_se = mean((data.signals.values(:,2) - data.signals.values(:,1)).^2);
%     w_m_se = mean((data.signals.values(:,4) - data.signals.values(:,3)).^2);
%     
%     m_se = v_m_se + w_m_se
    
    figure(1)
    vmse = mse(data.signals.values(:,2) - data.signals.values(:,1));%llanta una
    wmse = mse(data.signals.values(:,4) - data.signals.values(:,3));%llanta dos
    
   best= vmse + wmse;
    
   best
     plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
     legend('Robot Trajectory','Desired Trajectory' );
     
      %gtext('The Best =',double(best));
     
   % axis([-0.5,1.5,-0.5,0.5]);
      axis([-0.5,4,-0.5,1.5])
    %axis([-0.5,5.5,-0.5,1.5])
       % axis([-0.1,0.8,-0.5,1.5]);
 drawnow;
 
%  vmse = mse(data.signals.values(:,2) - data.signals.values(:,1));
%                wmse = mse(data.signals.values(:,4) - data.signals.values(:,3));
%                
%                a= vmse + wmse;            
%                
%                
%                datov=data.signals.values(:,1);
%            estimatev=data.signals.values(:,2);
%         ErrorRMSEV= rmse(datov,estimatev);       
%         
%            datow=data.signals.values(:,3);
%            estimatew=data.signals.values(:,4);           
%         ErrorRMSEW = rmse(datow,estimatew);
% 
%         b = ErrorRMSEV + ErrorRMSEW;
%         
%         c= iaev + iaew;
%         
   %close