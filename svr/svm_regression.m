% function interpol=svm_regression(x_test,y_learn,x_learn);
% regression with SVR and gaussian kernel
% x_learn : vector of dimension [nb_data,dimX]
% y_learn : vector of dimension [nb_data,dimY]
% x_test : vector of dimension [nb_data_test,dimX]
%
% Other use 1 :
% [interpol,corr]=svm_regression(x_test,y_learn,x_learn,y_valid);
% if we have validation data, it computes corr : the correlation vector
%
% Other use 2 :
% interpol=svm_regression(x_test,y_learn,x_learn,options);
% if we want to modify the gamma coeff, the kernel, ...
% type help init_options_regression for more details
%
% Other use 3 :
% [interpol,corr]=svm_regression(x_test,y_learn,x_learn,options,y_valid);
% same than before with validation data
%
% One can add the model in last output



function varargout=svm_regression(x_test2,y_learn2,x_learn2,options,y_valid);
% base values for optional arguments
if nargin==3
    options=init_options_regression;
    verite=0;
elseif nargin==4
    if isstruct(options);
        verite=0;
    else
        verite=1;
        y_valid=options;
        options=init_options_regression;
    end
else
    verite=1;
end
% centering the data
[x_learn,moy_xlearn,ecart_xlearn]=centre_donnees(x_learn2);
x_test=centre_donnees(x_test2,moy_xlearn,ecart_xlearn);
[y_learn,moy_ylearn,var_ylearn]=centre_donnees(y_learn2);

% getting the dimensions 
[Nlearning,dim]=size(x_learn);
[Nvalid,dim]=size(x_test);
[nb_pts_in,dim_in]=size(x_learn);
[nb_pts_out,dim_out]=size(y_learn);
[nb_pts_test,dim_test]=size(x_test);
if(dim_test~=dim_in)
    error('dimensions of x test and learn must fit');
end
if(nb_pts_out~=nb_pts_in)
    error('number of points in learning stage must be identical');
end
whole_data=[x_learn',x_test']';
x_learning=whole_data(1:nb_pts_in,:);
x_testing=whole_data(1+nb_pts_in:nb_pts_in+nb_pts_test,:);
if strcmp(options.kernel_type,'gaussian'); % parameters for learning
    if options.kernel_d==0
        stropt=['-s 4 -t 2 -n 0.5  -h 0 -c ' num2str(1)];
    else
        stropt=['-s 4 -t 2 -n 0.5 -h 0 -c ' num2str(1),' -g ' num2str(options.kernel_d)];
    end
    
elseif strcmp(options.kernel_type,'polynomial');
    stropt=['-s 4 -t 1  -h 0 -n 0.5 -c ' num2str(1)];
else
    error('invalid kernel');
end


% using svmtrain to learn from the data and svmpredict to apply to the tests
for i=1:dim_out
    model = svmtrain(y_learn(:,i),x_learning,stropt);
    sorties2(:,i)=svmpredict(x_testing(:,1)*0,x_testing,model);
end

% de-centering
sorties2=real(sorties2);
for i=1:dim_out
    sorties(:,i)=sorties2(:,i)*sqrt(var_ylearn(i))+moy_ylearn(i);
end

if verite==1
    
    for i=1:dim_out
        tmp = corrcoef(y_valid(:,i),sorties(:,i));
        corr(i)=tmp(2);
    end
    varargout={real(sorties),corr,model};
else
    varargout={sorties,model};
end
