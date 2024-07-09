; /newss für init, ssein und ssaus für ein- und ausschalten, f5 für substantive abarbeiten.
; test, if the %#.th parameter is occurs in the list of parameters %1 to %(#-1)
/def member =\
  /if ({#} < 2) /return 0%;\
  /else \
   /while ({#} > 1) \
    /if ({1} =~ {L1}) \
     /return 1%;\
    /endif%;\
    /shift%;\
   /done%;\
   /return 0%;\
  /endif

;zu ueberspringende worte
/def -i skipsearch=/set skipsearch=das der die nie du dich dir er es \
  so kein keine was ein eine lebenspunkte magiepunkte sowas ausgaenge \
  nord norden west den des wessen dessen westen ost osten sued sueden alles \
  von im in hier an dort deine freund freundin ferne atikel zeitung \
  alle freundschaftsband konzentrationspunkte vorsicht lebenspunkte deinen \
  fluchtrichtung nordosten nordwesten suedosten suedwesten dein deines mazoli \
  macke mackeii yeti woa mieze alcina in im aus etwa und wer wie was wieso \
  weshalb warum dieser damit mit wenn denn oder entweder maste lag vielleicht \
  eines wie ja dies ausser ohne dschinn schon diese deinem deiner als ich auf \
  leider sie dieses daraus muss wobei nach wird werden suedlich noerdlich \
  westlich oestlich na bisher gralkor eigentlich nur also aber man bei \
  ploetzlich wen jede fast offenbar um

/skipsearch
;grundsuchworte
/def -i newsearch=/set newsearch=wand waende boden decke himmel sonne wolke \
                                 wolken \      
/newsearch

;Startwerte einsetzen+schau
/def newss=/set untaktiv=1%;/set tosearch=%newsearch%;\
  /set searched=%skipsearch%;schau

;untersuchung beenden
/def -b'[19~' ssaus =\
  /set untaktiv=0%;\
  /set untaktiv

;untersuchung wieder aufnehmen
/def -b'[18~' ssein =\
  /set untaktiv=1%;\
  /set untaktiv

;regexp auf ankommende zeile(n)
/def -mregexp -F -i -p80000 -t'^(.*)$' getsearchline=\
  /if /test $[(untaktiv+0)]%;/then \
    /set checkline=%*%;\
    /checkthatline %*%;\
  /endif

;auseinandernehmen der ankommenden zeile
;solange parameter vorhanden, wenn gross anfangend,
;noch nicht in einer der suchlisten enthalten
;kleingeschriebenes wort an quellsuchliste anhaengen
/def -i checkthatline=\
  /while /test $[(%#)]%;/do \
    /if (regmatch('([A-Z]+[a-z]+)[^a-z]*',{1})) \
      /set tempexpr=$[tolower(%P1)]%;\
;     /if (strstr(tosearch,tempexpr) == -1 & \
;          strstr(searched,tempexpr) == -1 ) \
      /if /!member %tosearch %tempexpr%; /then \
        /if /!member %searched %tempexpr%; /then \
          /set tosearch=%tosearch %tempexpr%;\
        /endif%;\
      /endif%;\
    /endif%;\
    /shift%;\
  /done

;bindkey auf naechsten ausdruck in tastaturpuffer kopieren
;ausdruck aus quelliste entfernen und in zielliste eintragen
/def -i -b'[15~' forwardskip =\
  /fskip %tosearch
/def -i fskip =\
  /set searchstring=%1%;\
  /grab /x %searchstring%;\
  /if (regmatch('^([^ ]+) (.*)$',{tosearch})) \
   /set tosearch=%P2 %P1%;\
  /endif

/def -i -b'Ou' backwardskip =\
  /bskip %tosearch
/def -i bskip =\
  /if (regmatch('^(.*) ([^ ]+)$',{tosearch})) \
   /set tosearch=%P2 %P1%;\
   /set searchstring=%P2%;\
  /else%;\
   /set searchstring=%1%;\
  /endif%;\
  /grab /x %searchstring

/def x=\
  /if ({#}) \
   /delete %1 %tosearch%;\
   /addsearched %1%;\
  /endif%;\
  /send schau %* in raum

/def delete=\
  /set tosearch=%;\
  /let str=%1%;\
  /shift%;\
; /let str%; /set a=%*%; /set a%; \
  /while ({str} =~ {1}) \
   /shift%;\
;  /set a=%*%; /set a%; \
  /done%;\
  /set tosearch=%1%;\
  /shift%;\
  /while (0 < {#}) \
   /if ({1} !~ {str}) \
    /set tosearch=%tosearch %1%;\
;   /set tosearch%;\
   /endif%;\
   /shift%;\
  /done
  
/def -i addsearched=\
  /if /!member %searched %1%; /then \
    /set searched=%1 %searched%;\
  /endif 

/def reunt =\
/load ~/unt.tf
