clear;
%first
    %boundary condition
        w=1;a=3*pi;b=pi;%coefficient
        nx=100;ny=50;%setup the cutting number
        x_max=a;
        x_min=0;
        y_max=b;
        y_min=0;
        x_length=abs(x_max-x_min);
        y_length=abs(y_max-y_min);
        x_step=x_length/nx;
        y_step=y_length/ny;
        x_start=1;y_start=1;x_end=nx+1;y_end=ny+1;%matrix calculaiton setup
        x_range=x_min:x_step:x_max;
        y_range=y_min:y_step:y_max;
                u=zeros(ny+1,nx+1);
            for i=x_start:x_end
                for j=y_start:y_end
                    u(j,i)=(sinh(w*(y_range(j)))/sinh(w*b))*(sin(w*(x_range(i)))/sin(w*a));
                end
            end
        

figure;
        maxu=max(u,[],'all');
        %nU=u/maxu;
        contourf(x_range,y_range,u,200,'linecolor','non');
        %contourf(nu);
        title('laplace e.q.');
        xlabel('x');
        ylabel('y');
        colorbar;
        colormap("jet");