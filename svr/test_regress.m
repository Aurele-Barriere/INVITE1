unidimension=1;
if unidimension==1 % one dimension
    %%%%%% SVR 1D %%%%%%%%
    N = 1000;
    M = 1;
    t1 = rand(N,1)*10-5;
    t2 = rand(N,1)*10-5;
    
    b=7;
    y1=t1.*t1.*t1 + 13*randn(N,1)/2+b; % creating the data to learn from
    y2=t2.*t2.*t2 + 13*randn(N,1)/2+b; % exact values for the tests
    close all
    plot(t1,y1,'+'); % plot the initial data
    options=init_options_regression;
    
    [interpol,corr]=svm_regression(t2,y1,t1,options,y2);
    hold on;
    plot(t2,interpol,'r+'); % plot the tests
    ntitle=sprintf('correlation : %.4f',corr);title(ntitle);
    legend('X et Y learn','X et Y test');
    
else % two dimensions
    %%%%%% Multi-dimensionnel %%%%%%%%
    clear all;
    N = 1000;
    M = 1;
    Xlearn(:,1) = rand(N,1)*10-5;
    Xlearn(:,2) = rand(N,1)*6-2;
    Xtest(:,1) = rand(N,1)*10-5;
    Xtest(:,2) = rand(N,1)*6-2;
    b=7;
    Ylearn(:,1)=Xlearn(:,1).*Xlearn(:,1).*Xlearn(:,2) + Xlearn(:,2).*Xlearn(:,2).*Xlearn(:,2) - 7*Xlearn(:,1).*Xlearn(:,2)+randn(N,1)/2+b;
    Ylearn(:,2)=Xlearn(:,2).*Xlearn(:,2).*Xlearn(:,2) + Xlearn(:,1) - sqrt(Xlearn(:,2).*Xlearn(:,1))+randn(N,1)/3+b;
    
    Ytest(:,1)=Xtest(:,1).*Xtest(:,1).*Xtest(:,2) + Xtest(:,2).*Xtest(:,2).*Xtest(:,2) - 7*Xtest(:,1).*Xtest(:,2)+randn(N,1)/2+b;
    Ytest(:,2)=Xtest(:,2).*Xtest(:,2).*Xtest(:,2) + Xtest(:,1) - sqrt(Xtest(:,2).*Xtest(:,1))+randn(N,1)/3+b;
    options=init_options_regression;
    options.kernel_d=1;
    [interpol,corr]=svm_regression(Xtest,Ylearn,Xlearn,options,Ytest);
    close all
    % plot the result
    plot3(Xlearn(:,1),Xlearn(:,2),Ylearn(:,1),'+')
    hold on;
    plot3(Xtest(:,1),Xtest(:,2),Ytest(:,1),'r+')
    plot3(Xtest(:,1),Xtest(:,2),interpol(:,1),'g+')
    title('Sortie 1');
    legend('X et Y learn','X et Y test','X et Y estime');
    Xlearn=real(Xlearn);
    Xtest=real(Xtest);
    Ylearn=real(Ylearn);
    Ytest=real(Ytest);
    figure
    plot3(Xlearn(:,1),Xlearn(:,2),Ylearn(:,2),'+')
    hold on;
    plot3(Xtest(:,1),Xtest(:,2),Ytest(:,2),'r+')
    plot3(Xtest(:,1),Xtest(:,2),interpol(:,2),'g+')
    title('Sortie 2');
    legend('X et Y learn','X et Y test','X et Y estime');
end

%
%
%
% options:
%
% -s svm_type : set type of SVM (default 0)
%
% 	0 -- C-SVC
%
% 	1 -- nu-SVC
%
% 	2 -- one-class SVM
%
% 	3 -- epsilon-SVR
%
% 	4 -- nu-SVR
%
% -t kernel_type : set type of kernel function (default 2)
%
% 	0 -- linear: u'*v
%
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
%
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
%
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
%
% -d degree : set degree in kernel function (default 3)
%
% -g gamma : set gamma in kernel function (default 1/num_features)
%
% -r coef0 : set coef0 in kernel function (default 0)
%
% -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
%
% -n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
%
% -p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
%
% -m cachesize : set cache memory size in MB (default 100)
%
% -e epsilon : set tolerance of termination criterion (default 0.001)
%
% -h shrinking: whether to use the shrinking heuristics, 0 or 1 (default 1)
%
% -b probability_estimates: whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
%
% -wi weight: set the parameter C of class i to weight*C, for C-SVC (default 1)
%
% The k in the -g option means the number of attributes in the input data.
