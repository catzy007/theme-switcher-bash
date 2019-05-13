#include <gtk/gtk.h>

char file1[]="~/.config/tea-switcher-mode.cfg";
char file2[]="/usr/share/tealinux/ThemeSwitcher/theme-switcher.sh";
char imgDark[]="/usr/share/pixmaps/switcher-dark.png"; //ganti jika perlu
char imgLight[]="/usr/share/pixmaps/switcher-light.png"; //ganti jika perlu

//pointer ke gtk tray icon
GtkStatusIcon *tray_icon;

int getSwitcherMode(char *configFile){
	char command[256];
	char message[5];
	
//if first time run
	strcpy(command, "if [ ! -f "); strcat(command, file1);
	strcat(command, " ]; then echo 1 > ");
	strcat(command, file1); strcat(command, "; fi");
	system(command);

//check current status
	strcpy(command, "if [ $(cat ");
	strcat(command, configFile);
	strcat(command, ") = \"1\" ]; then echo 1; else echo 0; fi");
	//printf("%s\n",command); //debug_line_can_be_removed
	FILE *check;
	check=popen(command,"r");
	if(fgets(message, sizeof(message), check)==NULL){
		printf("ERROR!\n");
		exit(0);
	}
	pclose(check);

//return
	//return 1 if config file value is 1 
	if(message[0] == '1'){
		return 1;
	}
	//return 0 if config file value is 0
	return 0;
}

//on tray icon left clicked
void tray_icon_on_click(GtkStatusIcon *status_icon, gpointer user_data){
	system(file2);
	
	char commd[255];
	if(getSwitcherMode(file1)){
		switcher_mode_light();
	}else{
		switcher_mode_dark();
	}
}

//change icon to dark mode = icon light
void switcher_mode_dark(GtkStatusIcon *status_icon, gpointer user_data){
	gtk_status_icon_set_tooltip_text(tray_icon, "Switch to Light Mode");
	gtk_status_icon_set_from_file(tray_icon, imgDark);
}

//change icon to light mode = icon dark
void switcher_mode_light(GtkStatusIcon *status_icon, gpointer user_data){
	gtk_status_icon_set_tooltip_text(tray_icon, "Switch to Dark Mode");
	gtk_status_icon_set_from_file(tray_icon, imgLight);
}

//create main status icon
static GtkStatusIcon *create_tray_icon(){
	GtkStatusIcon *tray_icon;

	tray_icon = gtk_status_icon_new();
	g_signal_connect(G_OBJECT(tray_icon), "activate", G_CALLBACK(tray_icon_on_click), NULL);

//set icon based on current status
	if(getSwitcherMode(file1)){
		gtk_status_icon_set_tooltip_text(tray_icon, "Switch to Dark Mode");
		gtk_status_icon_set_from_file(tray_icon, imgLight);
	}else{
		gtk_status_icon_set_tooltip_text(tray_icon, "Switch to Light Mode");
		gtk_status_icon_set_from_file(tray_icon, imgDark);
	}
	
	gtk_status_icon_set_visible(tray_icon, TRUE);

	return tray_icon;
}

//main function
int main(int argc, char **argv) {
	
	gtk_init(&argc, &argv);
	tray_icon = create_tray_icon();
	gtk_main();

	return 0;
}
