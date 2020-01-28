# Runtime resource replacement

## Követelmények:
* IntelliJ IDEA
* exploeded deployment
* telepített war `web.xml`-ben a következő paraméterek:
    ```xml
    <context-param>
            <param-name>javax.faces.PROJECT_STAGE</param-name>
            <param-value>Development</param-value>
    </context-param>
    <context-param>
          <param-name>facelets.DEVELOPMENT</param-name>
          <param-value>true</param-value>
    </context-param>
    <context-param>
          <param-name>facelets.REFRESH_PERIOD</param-name>
          <param-value>1</param-value>
    </context-param>
    ```
* File Watcher plugin az IDEA-ban
* bash.exe a PATH környezeti változón (Cygwin bash alkalmazása problémát okozhat)
 
## File Watcher beállításai:
#### Files to watch
* File type: figyelni kívánt fájl típus (pl.:`XHTML`, `JavaScript`, `CSS`)
* Scope: `web`
##### Scope létrehozása:
Azaz ahol figyeljen a plugin.
* Name: `web`
* Pattern: `file[<modul>]:src/main/webapp//*` (pl.: `file[bkv-frontend]:src/main/webapp//*`)
#### Tool to Run on Changes
* Program: [path\to\script\fileWatcherCopyFile.bat](scripts/fileWatcherCopyFile.bat) (pl.: `$ProjectFileDir$\bkv-wildfly-config\src\main\resources\file-watcher\fileWatcherCopyFile.bat`)
* Arguments: Programnak átadott paraméterek 
1. <em>file</em>:                   forrásfile elérési útja az aktuális könyvtárhoz viszonyítva
1. <em>module</em>:                 web modul neve, ahová a fájlt be kell mésolni
1. <em>project root</em>:           project root elérése
1. <em>rootDirectoryForServer</em>: gyökérkönyvtár, ahol lehet keresni a deployolt war állományt
1. <em>logger</em>:                 ha meg van adva, debug üzenet kiírása
    
    (pl.: `$FileRelativePath$ $ModuleName$ $ProjectFileDir$ $ProjectFileDir$\bkv-wildfly-config\target xhtml_logger`)  		

* Working Directory and Environment Variables:
    * Working Directory: ahol a scriptek vannak (`$ProjectFileDir$\bkv-wildfly-config\src\main\resources\file-watcher`)

### Vizuális segédlet:
File Watcher

![fw](https://github.com/ballamark/filewatcher/blob/master/img/File%20Watcher_1.JPG)

Scope

![fws](https://github.com/ballamark/filewatcher/blob/master/img/File%20Watcher%20scope.JPG)
 