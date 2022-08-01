#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

struct datafield
{
	char	mdt[15];
	int	mnt;
	int	dnt;
	char  	time[5];
	char	e_code;
        char    nch,nch1;    // ..time, when heat not be calculated...
	float	t1;
	float	t2;
	float	t3;
        float   t4;
	float	m1;
	float	m2;
        float   m3;
        float   m4;
        float   q1;
        float   q2;
};

datafield *darray[45];
int	maxindex = -1;
bool	html = false;
char    snum[15];     

void ReadField(FILE *f, datafield *fld)
{
  char buf[200];

  fscanf(f,"%s",&buf);
   strcpy(fld->mdt,buf);
   fld->mdt[strlen(buf)+1]=0;
   fld->mnt=(int)((buf[3]-0x30)*10+(buf[4]-0x30)); // месяц
   fld->dnt=(int)((buf[0]-0x30)*10+(buf[1]-0x30)); // число
  fscanf(f,"%s",&buf);
  fscanf(f,"%s",&buf);
   fld->e_code=atoi(buf);
  fscanf(f,"%s",&buf);
   fld->t1=atof(buf);
  if(fld->t1<0) fld->t1=0;
  fscanf(f,"%s",&buf);
   fld->t2=atof(buf);
  if(fld->t2<0) fld->t2=0;
  fscanf(f,"%s",&buf);
   fld->m1=atof(buf); if(fld->m1>99999.999) fld->m1=0;
  fscanf(f,"%s",&buf);
   fld->m2=atof(buf); if(fld->m2>99999.999) fld->m2=0;
  fscanf(f,"%s",&buf);
   fld->q1=atof(buf); if(fld->q1>99999.999) fld->q1=0;
  fscanf(f,"%s",&buf);
   fld->t3=atof(buf);
  if(fld->t3<0) fld->t3=0;
  fscanf(f,"%s",&buf);
   fld->t4=atof(buf);
  if(fld->t4<0) fld->t4=0;
  fscanf(f,"%s",&buf);
   fld->m3=atof(buf); if(fld->m3>99999.999) fld->m3=0;
  fscanf(f,"%s",&buf);
   fld->m4=atof(buf); if(fld->m4>99999.999) fld->m4=0;
  fscanf(f,"%s",&buf);
   fld->q2=atof(buf); if(fld->q2>99999.999) fld->q2=0;
}

 datafield *fld;
 FILE *datafile;
 FILE *formfile;
 FILE *grfile;

int	m1, d1, m2, d2;
int     dty = 0;
int no_calc_time=0;
int no_calc_time1=0;

float	c_m1=0;
float   c_m2=0;
float   c_m3=0;
float   c_m4=0;

float	q_s1=0;
float	q_s2=0;
float	q_e1=0;
float	q_e2=0;
float	q_c1=0;
float	q_c2=0;

float	ts1=0;
float	ts2=0;
float	ts3=0;
float	ts4=0;

void calculate(void)
{
if (html==false) {
 fprintf(formfile,"+-----+---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
 fprintf(formfile,"За период с %02i/%02i по %02i/%02i\n",d1,m1,d2,m2);
 fprintf(formfile,"+-----+---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
 fprintf(formfile,"|Итого|%3i|             |%9.4f|%9.4f|%9.4f|%3i|      |      |%9.4f|%9.4f|%9.4f|\n",no_calc_time,c_m1,c_m2,q_e1-q_s1,no_calc_time1,c_m3,c_m4,q_e2-q_s2);
 fprintf(formfile,"+-----+---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
 fprintf(formfile,"|Ср/дн|   |%6.2f|%6.2f|%9.4f|%9.4f|%9.4f|   |%6.2f|%6.2f|%9.4f|%9.4f|%9.4f|\n",ts1/dty,ts2/dty,c_m1/dty,c_m2/dty,q_c1,ts3/dty,ts4/dty,c_m3/dty,c_m4/dty,q_c2);
 fprintf(formfile,"+-----+---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
 } else
 {
 fprintf(formfile,"    <tr>\n");
 fprintf(formfile,"        <td align=\"left\" colspan=\"13\"><font size=\"2\"\n");
 fprintf(formfile,"        face=\"Arial Cyr\"><strong>·┴ ╨┼╥╔╧─ ╙ %02i/%02i ╨╧ %02i/%02i</strong></font></td>\n",d1,m1,d2,m2);
 fprintf(formfile,"    </tr>\n");
 fprintf(formfile,"    <tr>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>щ╘╧╟╧:</strong></font></td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%i</strong></font></td>\n",no_calc_time);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m1);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m2);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",q_e1-q_s1);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%i</strong></font></td>\n",no_calc_time1);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m3);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m4);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",q_e2-q_s2);
 fprintf(formfile,"    </tr>\n");
 fprintf(formfile,"    <tr>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>є╥┼─╬┼┼:</strong></font></td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",ts1/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",ts2/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m1/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m2/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",q_c1);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"></font>&nbsp;</td>\n");
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",ts3/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",ts4/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m3/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",c_m4/dty);
 fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",q_c2);
 fprintf(formfile,"    </tr>\n");
 fprintf(formfile,"</table>\n");
 fprintf(formfile,"<br><br>\n");
 }
  no_calc_time=0;
  no_calc_time1=0;
  c_m1=0; c_m2=0; c_m3=0; c_m4=0;
  ts1=0; ts2=0; ts3=0; ts4=0;
 dty = 0;
}

void html_header()
{
fprintf(formfile,"<html>\n\n");
fprintf(formfile,"<head>\n");
fprintf(formfile,"<meta http-equiv=\"Content-Type\"\n");
fprintf(formfile,"content=\"text/html; charset=koi8-r\">\n");
fprintf(formfile,"<meta name=\"GENERATOR\" content=\"C_FORM program by Dmitry S.A.(NEMTEH Ltd.)\">\n");
fprintf(formfile,"<title>DIO-99 ECONOMIC</title>\n");
fprintf(formfile,"</head>\n\n");
fprintf(formfile,"<body bgcolor=\"#FFFFFF\">\n");
fprintf(formfile,"<table border=\"0\" align=\"center\" width=\"95%\">\n");
fprintf(formfile,"    <tr>\n");
fprintf(formfile,"        <td><font face=\"Arial Cyr\"><strong>є╥┼─╬┼╙╒╘╧▐╬┘┼\n");
fprintf(formfile,"        ╨╧╦┴┌┴╘┼╠╔ DIO-99 ECONOMIC</strong></font></td>\n");
fprintf(formfile,"    </tr>\n");
fprintf(formfile,"    <tr>\n");
fprintf(formfile,"        <td><font face=\"Arial Cyr\"><strong>No:%s</strong></font></td>\n",snum);
fprintf(formfile,"    </tr>\n");
fprintf(formfile,"</table>\n");
}

void header(void)
{
if (html==false) {
fprintf(formfile,"\n+-----+-----------------------------------------------+-----------------------------------------------+\n");
fprintf(formfile,"|     |                  Контур 1                     |                    Контур 2                   |\n");
fprintf(formfile,"|ДД/ММ|---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
fprintf(formfile,"|     |пр |tп,oC |tо,oC |  Vп,m3  |  Vо,m3  | Q,Гкал  |пр |tп,oC |tо,oC |  Vп,m3  |  Vо,m3  | Q,Гкал  |\n");
fprintf(formfile,"+-----+---+------+------+---------+---------+---------+---+------+------+---------+---------+---------+\n");
 }
 else
 {
fprintf(formfile,"<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" align=\"center\" width=\"95%\">\n");
fprintf(formfile,"    <tr>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong></strong></font>&nbsp;</td>\n");
fprintf(formfile,"        <td align=\"center\" colspan=\"6\"><font size=\"2\"\n");
fprintf(formfile,"        face=\"Arial Cyr\"><strong>ы╧╬╘╒╥ 1</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\" colspan=\"6\"><font size=\"2\"\n");
fprintf(formfile,"        face=\"Arial Cyr\"><strong>ы╧╬╘╒╥ 2</strong></font></td>\n");
fprintf(formfile,"    </tr>\n");
fprintf(formfile,"    <tr>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>фф/ээ</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>╨╥</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>t</strong><sub><strong>╨</strong></sub><strong>,\n");
fprintf(formfile,"        </strong><sup><strong>o</strong></sup><strong>є</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>t</strong><sub><strong>╧</strong></sub><strong>,\n");
fprintf(formfile,"        </strong><sup><strong>o</strong></sup><strong>є</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>V</strong><sub><strong>╨</strong></sub><strong>,\n");
fprintf(formfile,"        m</strong><sup><strong>3</strong></sup></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>V</strong><sub><strong>╧</strong></sub><strong>,\n");
fprintf(formfile,"        m</strong><sup><strong>3</strong></sup></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>Q,\n");
fprintf(formfile,"        ч╦┴╠</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>╨╥</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>t</strong><sub><strong>╨</strong></sub><strong>,\n");
fprintf(formfile,"        </strong><sup><strong>o</strong></sup><strong>є</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>t</strong><sub><strong>╧</strong></sub><strong>,\n");
fprintf(formfile,"        </strong><sup><strong>o</strong></sup><strong>є</strong></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>V</strong><sub><strong>╨</strong></sub><strong>,\n");
fprintf(formfile,"        m</strong><sup><strong>3</strong></sup></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>V</strong><sub><strong>╧</strong></sub><strong>,\n");
fprintf(formfile,"        m</strong><sup><strong>3</strong></sup></font></td>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>Q,\n");
fprintf(formfile,"        ч╦┴╠</strong></font></td>\n");
fprintf(formfile,"    </tr>\n");
 }
}

main(int argc, char *argv[])
{
 char buf[15];
 int  h_cnt = 0;
printf("Генератор отчетов DIO-99 ECONOMIC V 2.06-02\n\n");
if(argc<2)
{
 printf("Формат командной строки:\nCFORM.EXE ICx.BDT [html]\n\n");
 printf(" ICx.BDT - файл с данными из карты;\n");
 printf(" html    - необязательный параметр задающий вывод в формате HTML\n");
 return 0;
}
if (!strcmp(argv[2],"html"))
{
printf("\nТаблица генерируется в HTML формате кодировка KOI8-r\n");
html = true;
}
  datafile=fopen(argv[1],"r+t");
 if(!datafile)
  {
   printf("Файл с данными %s не найден!",argv[1]);
   return 0;
  }
if (html==false)
 formfile=fopen("form.txt","w+t"); else
   formfile=fopen("form.htm","w+t");

   fld = new datafield;

 fscanf(datafile,"%s",&buf);
 strcpy(snum,buf);

if(html==true) {
 html_header(); }
 else {
fprintf(formfile,"Среднесуточные показатели DIO-99 ECONOMIC.\n");
 printf("%s\n",snum);
 fprintf(formfile,"%s\n",snum);
}


 ReadField(datafile,fld);
 while(!feof(datafile))
 {
   ReadField(datafile,fld);
  h_cnt++;
  {
   int i = 0;
   char compared = 0;
    while(i<=maxindex)
     {
       if(strcmp(darray[i]->mdt,fld->mdt)==0)
	{
	  compared=1;
		if((fld->e_code & 0x01)||(fld->e_code & 0x02))
		{
			darray[i]->nch++;
		}

                if((fld->e_code & 0x04)||(fld->e_code & 0x08))
		{
                        darray[i]->nch1++;
		}
	  if(fld->t1!=0)

	   {
	    if(darray[i]->t1!=0) {
	    darray[i]->t1+=fld->t1;
	    darray[i]->t1/=2; } else
	     darray[i]->t1=fld->t1;
	   }
	  if(fld->t2!=0)
	   {
	    if(darray[i]->t2!=0) {
	    darray[i]->t2+=fld->t2;
	    darray[i]->t2/=2; } else
	     darray[i]->t2=fld->t2;
	   }
	  if(fld->t3!=0)
	   {
	    if(darray[i]->t3!=0) {
	    darray[i]->t3+=fld->t3;
	    darray[i]->t3/=2; } else
	     darray[i]->t3=fld->t3;
	   }
          if(fld->t4!=0)
	   {
            if(darray[i]->t4!=0) {
            darray[i]->t4+=fld->t4;
            darray[i]->t4/=2; } else
             darray[i]->t4=fld->t4;
	   }

	    darray[i]->m1+=fld->m1;
	    darray[i]->m2+=fld->m2;
            darray[i]->m3+=fld->m3;
            darray[i]->m4+=fld->m4;
           if(fld->q1>darray[i]->q1)
            darray[i]->q1=fld->q1;
           if(fld->q2>darray[i]->q2)
            darray[i]->q2=fld->q2;
	  break;
	}
      i++;
     }
    if(compared==0)
    {
     maxindex++;
     darray[maxindex] = new datafield;
     memcpy(darray[maxindex],fld,sizeof(datafield));
		if((fld->e_code & 0x01)||(fld->e_code & 0x02))
		{
			darray[maxindex]->nch=1;
		} else darray[maxindex]->nch=0;
                //
                if((fld->e_code & 0x04)||(fld->e_code & 0x08))
		{
                        darray[maxindex]->nch1=1;
                } else darray[maxindex]->nch1=0;
    }
 }
 }
 fclose(datafile);

 int mn,dy,mn1,dy1;
 char bf[5];
 char changed = 0;

 while(changed==0)
 {
 changed=1;
 for(int i=0;i<maxindex;i++)
 {
  // sort array by date
   if(darray[i]->mnt>darray[i+1]->mnt)
    {
      fld=darray[i]; darray[i]=darray[i+1];
     darray[i+1]=fld;
     changed=0;
    }
  }
 }
 // сортировка по числу

 changed = 0;

 while(changed==0)
 {
 changed=1;
 for(int i=0;i<maxindex;i++)
 {
 if(darray[i]->mnt==darray[i+1]->mnt) {
 if(darray[i]->dnt>darray[i+1]->dnt)
      {
      fld=darray[i]; darray[i]=darray[i+1];
      darray[i+1]=fld;
      changed=0;
      }
   }
 }
}
header();

int old_month = darray[0]->mnt;
m1 = old_month;
d1 = darray[0]->dnt;

  q_s1=darray[0]->q1;
  q_s2=darray[0]->q2;

int i;

for(i=0;i<=maxindex;i++)
{
if(old_month!=darray[i]->mnt)
 {
  q_e1=darray[i-1]->q1;
  q_e2=darray[i-1]->q2;
  q_c1=(q_e1-q_s1)/(float)dty;
  q_c2=(q_e2-q_s2)/(float)dty;
  m2 = darray[i-1]->mnt;
  d2 = darray[i-1]->dnt;
  calculate();
  old_month = darray[i]->mnt;
  m1 = old_month;
  d1 = darray[i]->dnt;
 header();
  q_s1=darray[i]->q1;
  q_s2=darray[i]->q2;
 }
 dty++;
 printf(" %s |",darray[i]->mdt);
if(html==false) {
fprintf(formfile,"|%s|%3i|%6.2f|%6.2f|%9.4f|%9.4f|%9.3f|%3i|%6.2f|%6.2f|%9.4f|%9.4f|%9.3f|\n",darray[i]->mdt,
	 darray[i]->nch,darray[i]->t1,
         darray[i]->t2,darray[i]->m1,darray[i]->m2,darray[i]->q1,darray[i]->nch1,
         darray[i]->t3,darray[i]->t4,darray[i]->m3,darray[i]->m4,darray[i]->q2);
 } else
 {
fprintf(formfile,"    <tr>\n");
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%s</strong></font></td>\n",darray[i]->mdt);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%3i</strong></font></td>\n",darray[i]->nch);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",darray[i]->t1);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",darray[i]->t2);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",darray[i]->m1);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",darray[i]->m2);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.3f</strong></font></td>\n",darray[i]->q1);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%3i</strong></font></td>\n",darray[i]->nch1);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",darray[i]->t3);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%6.2f</strong></font></td>\n",darray[i]->t4);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",darray[i]->m3);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.4f</strong></font></td>\n",darray[i]->m4);
fprintf(formfile,"        <td align=\"center\"><font size=\"2\" face=\"Arial Cyr\"><strong>%9.3f</strong></font></td>\n",darray[i]->q2);
fprintf(formfile,"    </tr>\n");
}
  no_calc_time+=darray[i]->nch;
  no_calc_time1+=darray[i]->nch1;
 c_m1+=darray[i]->m1;
 c_m2+=darray[i]->m2;
 c_m3+=darray[i]->m3;
 c_m4+=darray[i]->m4;

 ts1+=darray[i]->t1;
 ts2+=darray[i]->t2;
 ts3+=darray[i]->t3;
 ts4+=darray[i]->t4;

 m2 = darray[i]->mnt;
 d2 = darray[i]->dnt;
}
  q_e1=darray[i-1]->q1;
  q_e2=darray[i-1]->q2;
  q_c1=(q_e1-q_s1)/(float)dty;
  q_c2=(q_e2-q_s2)/(float)dty;
 calculate();

if (html==true) {
 fprintf(formfile,"</body>\n");
 fprintf(formfile,"</html>\n"); }

fclose(formfile);
fclose(grfile);
return 0;
}