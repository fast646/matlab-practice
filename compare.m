clear;
nx=100;ny=50;
w=1;a=3*pi;b=pi;%coefficient
%figure setup
f=figure('Name','soluction','NumberTitle','off','Alphamap',1);
t=tiledlayout(f,2,2);
colormap(f,'jet');
%boundary condition
    x_max=a;    x_min=0;
    y_max=b;    y_min=0;
    x_length=abs(x_max-x_min);
    y_length=abs(y_max-y_min);
    x_step=x_length/nx;
    y_step=y_length/ny;
    x_region=x_min:x_step:x_max;
    y_region=y_min:y_step:y_max;
%analytical soluction
    u=zeros(ny+1,nx+1);
    for i=1:nx+1
        for j=1:ny+1
            u(j,i)=(sin(w*x_region(i))/sin(w*a))*(sinh(w*y_region(j))/sinh(w*b));
            
        end
    end
    clear i j;
    %figure
        T1=nexttile(t,1);
        TO=contourf(T1,x_region,y_region,u,200,'linecolor','non');
        title(T1,'analytical soluction');
        xlabel(T1,'x');
        ylabel(T1,'y');
        lim=clim(T1);
%numerical soluction
    %matrix caculation
        x_start=1;y_start=1;
        x_end=nx+1;y_end=ny+1;
        T=10000;%time
    U=zeros(ny+1,nx+1);
    U(1,:)=0;
    U(:,1)=0;
    U(:,x_end)=sinh(w*y_region)/sinh(w*b);
    U(y_end,:)=sin(w*x_region)/sin(w*a);
    deno=0.5/(x_step^2+y_step^2);
    for k=1:T
        for i=2:nx
            for j=2:ny
                U(j,i)=deno*( ...
                    (y_step^2)*(U(j,i+1)+U(j,i-1) ...
                    )+((x_step^2)*(U(j+1,i)+U(j-1,i))) ...
                    );
            end
        end
    end
    %figure
        T2=nexttile(t,2);
        contourf(T2,x_region,y_region,U,200,'linecolor','non');
        title(T2,'numerical soluction');
        xlabel(T2,'x');
        ylabel(T2,'y');
        clim(T2,lim);
%compare
    error=u-U;
    %figure
        T3=nexttile(t,3,[1,2]);
        contourf(T3,x_region,y_region,error,200,'linecolor','non');
        title(T3,'numerical soluction');
        xlabel(T3,'x');
        ylabel(T3,'y');
        clim(T3,lim);
        colorbar(T3,'northoutside');