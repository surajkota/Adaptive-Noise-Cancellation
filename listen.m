j_theta = zeros(250, 250);   % initialize j_theta
theta0_vals = linspace(-3, 3, 250);
theta1_vals = linspace(-3, 3, 250);

for i = 1:length(theta0_vals)
	  for j = 1:length(theta1_vals)
		theta_val_vec = [theta0_vals(i) theta1_vals(j)]';
		h_theta = (X*theta_val_vec);
		j_theta(i,j) = 1/(2*69998)*sum((h_theta - Y(1:69998)).^2);
    end
end
figure;
contour(theta0_vals,theta1_vals,10*log10(j_theta.'))
xlabel('w0'); ylabel('w1')
title('Cost function J = MSE');
hold on;
plot(w(1,:),w(2,:),'.');
title('Performance Contour for filter order 2 and step size 0.001 using NLMS');
%plot(theta_stoch_vec_v(:,1),theta_stoch_vec_v(:,2),'rs.');
%plot(theta_batch_vec_v(:,1),theta_batch_vec_v(:,2),'kx.');