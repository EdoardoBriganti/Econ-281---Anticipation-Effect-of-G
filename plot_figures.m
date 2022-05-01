clc
clear

data_tab = readtable("procurement_spending.xlsx","sheet","Procurement Spending");

quarters = string(table2array(data_tab(:,2)))+"Q"+string(table2array(data_tab(:,3)));
quarters = quarters(1:end-2);
T = size(quarters,1);
time = (1:1:T)';

G = table2array(data_tab(1:end-2,4));
O = table2array(data_tab(1:end-2,5));
Y = table2array(data_tab(1:end-2,7));


budget_act_2011 = find(quarters=="2011Q1");
trump_election = find(quarters=="2016Q4");

figure(1)
labels = 3:8:T;
subplot(1,2,1),
%     plot(time,G,"-ob",time,O,"--r","linewidth",1.5)
%     legend("Spending","Obligations",'fontsize',30)
    plot(time,G,"-ob","linewidth",1.5)
    grid on
    ylabel("Billions of USD (\$)","interpreter","latex")
    set(gca,'Xtick',labels)
    set(gca,'Xticklabel',quarters(labels))
    xtickangle(45)
    xline(budget_act_2011,'--k','Budget Act - Obama 2011',...
        "LabelVerticalAlignment","bottom",'fontsize',20,"linewidth",1.5)
    xline(trump_election,'--k',"Election of Trump - 8 Nov. 2016",...
        "LabelVerticalAlignment","top",'fontsize',20,"linewidth",1.5)
    set(gca,'fontsize',25)
    
subplot(1,2,2),
%     plot(time,100*G./Y,"-ob",time,100*O./Y,"--r","linewidth",1.5)
%     legend("Spending","Obligations",'fontsize',30)
    plot(time,100*G./Y,"-ob","linewidth",1.5)
    grid on
    ylabel("Share of GDP (\%)","interpreter","latex")
    set(gca,'Xtick',labels)
    set(gca,'Xticklabel',quarters(labels))
    xtickangle(45)
    xline(budget_act_2011,'--k','Budget Act - Obama 2011',...
        "LabelVerticalAlignment","bottom",'fontsize',20,"linewidth",1.5)
    xline(trump_election,'--k',"Election of Trump - 8 Nov. 2016",...
        "LabelVerticalAlignment","top",'fontsize',20,"linewidth",1.5)
    set(gca,'fontsize',25)
    
    
%% FIgure 2
clc
clear

data_tab = flipud(readtable("procurement_spending.xlsx","sheet","comparison"));

date = string(table2array(data_tab(:,1)));


start = 5;
date = date(start:end);
T = size(date,1);
time = (1:1:T)';
SP500 = 100*table2array(data_tab(start:end,2));
Boeing = 100*table2array(data_tab(start:end,3));
Raytheon = 100*table2array(data_tab(start:end,4));
NorthropGrumman = 100*table2array(data_tab(start:end,5));

trump_election = find(date=="08-Nov-2016");

figure(2)
labels = 1:2:T;
subplot(1,2,1),
    plot(time,SP500,"b","linewidth",1.5,'displayname','SP500')
    hold on
    plot(time,Boeing,':','Color',[0.5 0 0.8],"linewidth",1.5,'displayname','Boeing')
    plot(time,Raytheon,'-.','Color',[0.5 0 0.8],"linewidth",1.5,'displayname','Raytheon')
    plot(time,NorthropGrumman,'--','Color',[0.5 0 0.8],"linewidth",1.5,'displayname','Northrop-Grumman')
    hold off
    lgd = legend;
    lgd.Location = 'northwest';
    grid on
    ylabel("Weekly Return (\%)","interpreter","latex")
    set(gca,'Xtick',labels)
    set(gca,'Xticklabel',date(labels))
    xtickangle(45)
    xline(trump_election,'--k',"Election of Trump - 8 Nov. 2016",...
        "LabelVerticalAlignment","bottom",'fontsize',20,"linewidth",1.5,'HandleVisibility','off')
    set(gca,'fontsize',25)
    yline(0,'k',"linewidth",1.5,'HandleVisibility','off')
    title("Weekly Returns","interpreter","latex")
    
subplot(1,2,2),
    plot(time,Boeing-SP500,':',...
        time,Raytheon-SP500,'-.',...
        time,NorthropGrumman-SP500,'--',...
        'Color',[0.5 0 0.8],"linewidth",1.5)
    legend("Boeing","Raytheon","Northrop-Grumman",...
        'fontsize',20,'location','northwest')
    grid on
    ylabel("Weekly Return (\%)","interpreter","latex")
    set(gca,'Xtick',labels)
    set(gca,'Xticklabel',date(labels))
    xtickangle(45)
    xline(trump_election,'--k',"Election of Trump - 8 Nov. 2016",...
        "LabelVerticalAlignment","bottom",'fontsize',20,"linewidth",1.5,'HandleVisibility','off')
    set(gca,'fontsize',25)
    yline(0,'k',"linewidth",1.5,'HandleVisibility','off')
    title("Weekly Excess Returns","interpreter","latex")
    