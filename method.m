%clear;
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
        T=10000;%matrix calculaiton_time setup
        deno=0.5/((x_step^2)+(y_step^2));
        x_range=x_min:x_step:x_max;
        y_range=y_min:y_step:y_max;
        u=zeros(ny+1,nx+1);
        u(:,x_start)=0;
        u(y_start,:)=0;
        u(:,x_end)=sinh(w*y_range)/sinh(w*b);
        u(y_end,:)=sin(w*x_range)/sin(w*a);
        %nu=u;
%second
    %finite difference method
        for k=1:T
            for i=x_start+1:x_end-1
                for j=y_start+1:y_end-1
                    u(j,i)=deno*( ...
                        (x_step^2)*(u(j+1,i)+u(j-1,i)) ...
                        +(y_step^2)*(u(j,i+1)+u(j,i-1)));
                end
            end
        end
%end
    %figure
        figure;
        %maxu=max(u,[],'all');
        %nu=u/maxu;
        contourf(x_range,y_range,u,200,'linecolor','non');
        %contourf(nu);
        title('laplace e.q.');
        xlabel('x');
        ylabel('y');
        colorbar;
        colormap("jet");
        