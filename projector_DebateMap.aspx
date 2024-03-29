﻿<%@ Page Title="nejoba Netzwerk-Karte" Language="IronPython" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="projector_DebateMap.aspx.py" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" Runat="Server">

    <script src="<%# ResolveUrl("~/js/OpenLayers-nejoba.js") %>" type="text/javascript"></script>
    <script src="<%# ResolveUrl("~/js/neJOBaBrowserBrain.js") %>" type="text/javascript"></script>
    <script src="<%# ResolveUrl("~/js/MatrixManager.js") %>" type="text/javascript"></script>

    <style type="text/css">
        /* for bootstrap compatibility */
        img.olTileImage {
            max-width: none;
        }
        /* for bootstrap compatibility */

        body {
            margin: 0;
            padding-top: 0px;
            padding-bottom: 10px;
        }
        
        #map 
        {
            height: 700px;
            top:21px;
            padding: 0.5em 0.5em 0.5em 0.5em;
        }
        
    </style>


</asp:Content>

<asp:Content ID="ContentTop" ContentPlaceHolderID="CoPlaTop" Runat="Server">
</asp:Content>

<asp:Content ID="ContentBottom" ContentPlaceHolderID="CoPlaBottom" Runat="Server">

    <!-- toolbar with buttons  ######## ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div class="row">
        <div class="span4 btn-toolbar pull-left">
            <br />
            <div class="btn-group">
                <!-- <a id="back_to_start"    class="btn" href="#"><i class="icon-backward"></i></a> -->
                <a id="back_in_list"     class="btn" title="Zurück blättern" data-placement="bottom" data-toggle="tooltip" data-original-title="Zurück"><i class="icon-step-backward"></i></a>
                <a id="open_modal"       class="btn" href="#srchDialg" role="button" data-toggle="modal" title="Suchen" data-placement="bottom" data-original-title="Suchen"><i class="icon-search"></i></a>
                <a id="foreward_in_list" class="btn disabled" role="button" data-toggle="modal" title="Vorwärts blättern" data-placement="bottom" data-toggle="tooltip" data-original-title="Weiter"><i class="icon-step-forward"></i></a>
                <a id="show_bookmark"    class="btn" role="button" data-toggle="modal" title="Link erhalten" data-placement="bottom" data-toggle="tooltip" data-original-title="Lesezeichen"><i class="icon-book"></i></a>
                <!-- <a id="foreward_to_end"  class="btn" href="#"><i class="icon-forward"></i></a> -->
                <a id="divider"          class="btn disabled" role="button" data-toggle="modal" ></a>
                <a id="open_list"        class="btn" title="Zur Liste (mit Suchparametern)" data-placement="bottom" data-toggle="tooltip" data-original-title="Zur Listenansicht"><i class="icon-list"></i></a>
                
                <a id="show_help"        class="btn" href="#guidance" role="button" title="Anleitung" data-placement="bottom" data-toggle="modal" data-original-title="Anleitung"><i class="icon-info-sign"></i></a>
            </div>
        </div>
        <div class="span8"></div>
    </div>


    <!-- map-div shows the world ###### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div class="row" id="div_projection_of_data">
        <div id="map" class="span12"></div>
    </div>


    <!-- search dialog      ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="srchDialg" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4><asp:Label ID="Label7" runat="server" Text="erweiterte Suche " /></h4>
        </div>
        <div class="modal-body">
            <div class="tabbable">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab_Ort" data-toggle="tab">Ort</a></li>
                    <li><a href="#tab_Termin" data-toggle="tab">Termin</a></li>
                    <li><a href="#tab_Thema" data-toggle="tab">Thema</a></li>
                    <li><a href="#tab_Rubrik" data-toggle="tab">Rubrik</a></li>
                </ul>
                <div class="tab-content">
                    <div id="tab_Ort" class="tab-pane active">
                        <h5>
                            <asp:Label ID="Label6" runat="server" Text="Ort festlegen"></asp:Label>
                            <br />
                            <small>Gilt nur für aktuelle Sicht!</small>
                            <hr />
                        </h5>
                        
                        <h5>
                            <asp:Label ID="Label21" class="span4" runat="server" Text="Land" />
                            <asp:DropDownList ID="sel_country" class="span6 offset1" runat="server" EnableViewState="false" />
                        </h5>

                        <h5>
                            <asp:Label ID="lblCityInpt" class="span4" runat="server" Text="Stadt" />
                            <asp:TextBox ID="txbx_city" class="typeahead span6 offset1" runat="server" EnableViewState="false" autocomplete="off" disabled/>
                        </h5>

                        <h5>
                            <asp:Label ID="lblPstCode" class="span4" runat="server" Text="Postleitzahl" />
                            <asp:TextBox ID="txbx_postCode" class="span6 offset1" runat="server" EnableViewState="false" disabled/>
                        </h5>

                        <div>
                            <hr />
                            <strong><asp:Label ID="Label15" runat="server" Text="nejoba macht glücklich :-)<br /><br />" /></strong>
                        </div>
                    </div>

                    <div id="tab_Termin" class="tab-pane">
                        <h5>
                            <asp:Label ID="Label5" runat="server" Text="Termine"></asp:Label>
                        </h5>
                        <h5>
                            <asp:Label ID="lbl_date" class="span4" runat="server" Text="Start-Termin" />
                            <asp:TextBox ID="txbx_timeFrom" class="span6 offset1" runat="server" autocomplete="off" EnableViewState="false" ToolTip="Trage hier den Tag der Veranstalltung ein. Wenn die Veranstalltung mehrere Tage dauert ist dies der erste Tag."></asp:TextBox>
                        </h5>
                        <h5>
                            <asp:Label ID="Label22" class="span4" runat="server" Text="End-Termin" />
                            <asp:TextBox ID="txbx_timeTo" class="span6 offset1" runat="server" autocomplete="off" EnableViewState="false" ToolTip="Wenn die Veranstaltung mehrere Tage dauert, wird hier der Schlusstag eingetragen. WICHTIG: Wenn der Termin nicht über mehrere Tage andauert lass dieses Feld leer."></asp:TextBox>
                        </h5>
                        <div>
                            <asp:Label ID="Label10" runat="server" Text="Ein Beitrag läßt sich in nejoba mit einem Start- und Endtermin verknüpfen.<br />" />
                            <asp:Label ID="Label11" runat="server" Text="Auf diese Weise entsteht eine Datenbank mit der Info wann welche Veranstallungen stattfinden.<br /><br />" />
                            <strong><asp:Label ID="Label12" runat="server" Text="nejoba zeigt Dir was abgeht in deiner Stadt<br /><br />" /></strong>
                        </div>
                    </div>

                    <div id="tab_Thema" class="tab-pane">
                        <h5>
                            <asp:Label ID="Label4" runat="server" Text="regionale Themen (Hashtags)"></asp:Label>
                            <hr />
                            <asp:Label ID="lbl_hashtag" class="span4" runat="server" Text="Hashtag" />
                            <asp:TextBox ID="txbx_hashtag" class="span6 offset1 typeahead" runat="server" EnableViewState="false" autocomplete="off"/>
                        </h5>
                        <br />
                        <div>
                            <asp:Label ID="Label8" runat="server" Text="Regionale Themen sind Hashtags in nejoba. Es werden Stichwörter mit einem '#' markiert. So entsteht eine regionale Themengruppe.<br />" />
                            <br />
                            <strong><asp:Label ID="Label16" runat="server" Text="nejoba hat eine Antwort<br /><br />" /></strong>
                        </div>
                    </div>
                    <div id="tab_Rubrik" class="tab-pane">
                        <h5><asp:Label ID="Label1" runat="server" Text="nejoba Rubriken"></asp:Label></h5>
                        <div>
                            <asp:Label ID="Label_2" runat="server" Text="Die Rubriken funktionieren wie man es von den Kleinanzeigen in Zeitungen kennt.<br/>Der Clou : Wenn du eine Oberrubrik wählst findet nejoba auch alle untergeordneten Rubriken.<br /><br />" />
                            
                        </div>
                        <h5>
                            <asp:Label ID="Label13" class="span4 offset1" runat="server" Text="Einsortieren: " />
                            <button id="btn_selectRubric" type="button" class="span4 offset1 btn btn-success" >Rubrick wählen</button>
                            <!--<asp:Image ID="imgOLD_selectRubric" runat="server"  style="cursor: pointer;" ImageUrl="~/style/pic/64_call_forum.png" ToolTip="Beiträge aus Rubriken suchen"  />-->
                        </h5>
                        <div class="span10 offset1"><br /></strong></div>
                        <h5>
                            <asp:Label ID="Label9" class="span4 offset1" runat="server" Text="Gewählt: " />
                            <asp:TextBox ID="txbx_itemname2" runat="server" class="span4 offset1" EnableViewState="false" ToolTip="Die gewählte Rubrik" Enabled="false" />
                        </h5>
                        <div class="span10"><strong><asp:Label ID="Label17" runat="server" Text="nejoba verbindet Menschen<br /><br />" /></strong></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id='deleteSearch' class="btn" type="button" >Löschen</button>
            <button class="btn" data-dismiss="modal" aria-hidden="true" type="button" >Abbrechen</button>
            <button id='startSearch' class="btn btn-primary" type="button" >Suchen</button>
        </div>
    </div>


    <!-- link-reuse-dlg     ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="linkreuse" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="linkreuseLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="reuseLabel">Link zur Wiederverwendung</h3>
        </div>
        <div class="modal-body">
            <p>Der folgende Link dient dazu deine gefilterte Ansicht wiederzuverwenden. Er öffnet also die Karte mit den jetzt gültigen Suchkriterien.</p>
            <br />
            <div><a id="extLinkDisplay"></a></div>
            <br />
            
            <a id="post_on_diaspora" ><img class="btn" src="style/pic/diaspora_icon_64x64.png" alt="Teilen auf diaspora" style="height:48px; width:48px;" data-toggle="tooltip" title="Teilen auf *diaspora"/></a>
            <a id="post_on_facebook" ><img class="btn" src="style/pic/facebook_icon_64x64.png" alt="Teilen auf facebook" style="height:48px; width:48px;" data-toggle="tooltip" title="Teilen auf facebook"/></a>
            

            <br />
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Fertig</button>
        </div>
    </div>


    <!-- short-description  ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="shortdescription" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="linkreuseLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4>Wie geht Nachbarschaft im Internet?</h4>
        </div>
        <div class="modal-body">
        <strong>
            <iframe width="420" height="315" src="//www.youtube.com/embed/rc5B737Q6LE?rel=0" frameborder="0" allowfullscreen></iframe>
            <p>
            Wie wäre eine öffentliche Pinnwand deiner Stadt? Ein schwarzes Brett für deinen Heimatort? Fragen stellen, Angebote machen und Informationen weitergeben. Von jedem für jeden?
            </p>
            <br />
            <p>
            Willkommen bei nejoba, dem neuen Info-Punkt für deine Stadt im Netz. 
            </p>
        </strong>
        <ul>
            <li>Veröffentliche Texte, Bilder und Videos</li>
            <li>Markiere interessante Orte auf der Karte</li>
            <li>Lege Termine für Veranstaltungen fest</li>
            <li>Gruppiere Themen mit Hashtags</li>
            <li>Verlinke auf Webseiten aus deiner Region</li>
        </ul>
        <br />
        <h5>Wofür kann man das gebrauchen?</h5>

        <p>Einige Beispiele:</p>

        <p><strong>Du brauchst jemanden der dir beim Umzug hilft? </strong><br/>Frag doch erstmal deine Nachbarn.</p>
        <p><strong>Du willst auf eine Veranstaltung hinweisen? </strong><br/>Lege einen Termin fest und markiere den Veranstaltungsort auf der Karte.</p>
        <p><strong>Du möchtest über das letzte Fußballspiel der Regionalliga berichten? </strong><br/>Veröffentliche ein Fotoalbum im regionalen Forum.</p>
        <p><strong>Du möchtest deine Firma vorstellen oder Sonderangebote anbieten? </strong><br/>Die Plattform ist auch für kommerzielle Nutzung offen.</p>
        <p><strong>Möchtest Du eine Initiative organisieren? </strong><br/>Nutze die regionalen Hashtags und informiere über Treffen und Aktionen.</p>
        <p><strong>Du suchst Alltagshilfen für deine Großeltern? </strong><br/>Suche nach Pflegekräften aus deiner Region.</p>
        <p><strong>Deine Katze ist weggelaufen? </strong><br/>Veröffentliche eine Suchanzeige mit ihrem Foto und deiner Handy-Nummer.</p>
        <p><strong>Du suchst Zeugen für einen Unfall? </strong><br/>Markiere den Unfallort und beschreibe was passiert ist.</p>
        <p><strong>Du willst ein Straßenfest organisieren? </strong><br/>Informiere die Anwohner über das Forum.</p>
        <p><strong>Willst du eine Fahrgemeinschaft gründen? </strong><br/>Zeige auf der Karte wohin es gehen soll und suche nach Leuten mit dem gleichen Ziel.</p>
        <br />
        <p>was auch immer.........nejoba nützt.</p>
        <br /><br />
        <strong>
            Nachbarn vernetzen sich. Wir machen das Internet regional. 
            <br />
            Mit nejoba entsteht die Nachbarschaft 2.0. 
        </strong>
        <p></p>
        <br /><br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="wbf_help/help_debates.aspx" Target="_blank">Zur Bedienungsanleitung</asp:HyperLink>
        <br /><br />
        <asp:HyperLink ID="HyperLink_YouTube" runat="server" NavigateUrl="http://www.youtube.com/user/nejobavideo" Target="_blank">Videos zum Thema nejoba auf YouTube</asp:HyperLink>
        <br /><br />
        <asp:HyperLink ID="HyperLink_facebook" runat="server" NavigateUrl="https://www.facebook.com/nejoba" Target="_blank">Unser Benutzerforum auf facebook.</asp:HyperLink>
        </div>
        
        <div class="modal-footer">
            <button class="btn btn-success" data-dismiss="modal" aria-hidden="true">Fertig</button>
        </div>
    </div>

    <!-- wait while load    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="loadNwait" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="loadNWaitLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="H2">
                <asp:Label ID="lblWaitTop" runat="server" Text="Die Daten werden geladen."></asp:Label>
            </h3>
        </div>
        <div class="modal-body">
            <img src="http://www.nejoba.net/njb_02/style/pic/searching.gif" />
        </div>
        <div class="modal-footer">
            <asp:Label ID="lblWaitASecond" runat="server" Text="Entschleunige Dich :-)"></asp:Label>
        </div>
    </div>


    <!-- nothing-found      ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="noDataFound" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="loadNWaitLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="H3">
                <asp:Label ID="Label20" runat="server" Text="Nichts gefunden."></asp:Label>
            </h3>
        </div>
        <div class="modal-body">
            <img src="http://www.nejoba.net/njb_02/style/pic/noDataFound.png" />
        </div>
        <div class="modal-footer">
            <asp:Label ID="Label23" runat="server" Text="Es konnten keine Daten gefunden werden,<br /> die zu den verwendeten Suchparametern passen würden.<br />Diese Tatsache ist für alle Beteiligte zutiefst unbefriedigend.<br />Vielleicht hilft dir die Antwort   "></asp:Label>
            <a href="http://de.wikipedia.org/wiki/42_%28Antwort%29" target="_blank" ><strong>42</strong></a> 
            <br />
            <button class="btn" data-dismiss="modal" aria-hidden="true">Ok</button>
        </div>
    </div>


    <!-- no-more-data   r   ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="endOfDataReached" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="H4">
                <asp:Label ID="Label24" runat="server" Text="Keine weiteren Daten."></asp:Label>
            </h3>
        </div>
        <div class="modal-body">
            <img src="http://www.nejoba.net/njb_02/style/pic/noDataFound.png" />
        </div>
        <div class="modal-footer">
            <asp:Label ID="Label25" runat="server" Text="Weitere Veröffentlichungen gibt es zur Zeit nicht."></asp:Label>
            <br /><br />
            <button class="btn" data-dismiss="modal" aria-hidden="true">Ok</button>
        </div>
    </div>


    <!--    guidance        ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="guidance" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="linkreuseLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4>Anleitung: Wie finde ich etwas im Nachbarforum?</h4>
        </div>
        <div class="modal-body">
        <br />
        <iframe width="480" height="360" src="//www.youtube.com/embed/m5Kg7KOVaYU" frameborder="0" allowfullscreen></iframe>
        <br /><br />
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="./wbf_help/help_debates.aspx" Target="_blank">Zur Bedienungsanleitung</asp:HyperLink>
        <br /><br />
        <asp:HyperLink ID="HyperLink33" runat="server" NavigateUrl="http://www.youtube.com/user/nejobavideo" Target="_blank">Videos zum Thema nejoba auf YouTube</asp:HyperLink>
        <br /><br />
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="https://www.facebook.com/nejoba" Target="_blank">Unser Benutzerforum auf facebook.</asp:HyperLink>
        </div>
        
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true">Fertig</button>
        </div>
    </div>


    <!--    rubricChooser   ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div id="rubricChooser" style="display:none;">
        <!--    dsplydiv_rubric ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
        <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
        <div id="dsplydiv_rubric" class="well">
            <!-- ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> <!-- ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
            <h4>
                <ul class="nav nav-tabs" id="rubricTabs">
                    <li class="active"><a href="#economy" data-toggle="tab">Wirtschaft</a></li>
                    <li><a href="#leisure" data-toggle="tab">Freizeit</a></li>
                    <li><a href="#society" data-toggle="tab">Gesellschaft</a></li>
                </ul>
            </h4>
            <!-- ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> <!-- ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
            <div class="tab-content" id="rubricTabDef" >
                <div class="tab-pane active" id="economy">
                    <div class="row" >
                        <div class="span1"></div>
                        <div class="span10 well label-important" style="color:White;height:150px;">
                            <h4>
                                <asp:Label ID="Label2" runat="server" Text="Wirtschaft"></asp:Label>
                            </h4>
                            <p>
                                <asp:Label ID="Label3" runat="server" Text="Informiere dich regional über Unternehmen, finde einen Job über die Job-Börse oder durchstöbere die Kleinanzeigen."></asp:Label>
                                <br />
                                <asp:Label ID="Label14" runat="server" Text="Die folgenden Rubriken stehe auf nejoba zur Verfügung. Du kannst dich informieren oder selbst einen Beitrag hinzufügen. Wähle was dich interessiert."></asp:Label>
                                <br />
                            </p>
                        </div>
                        <div class="span1"></div>
                    </div>
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_business" class="span4 well label-important" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_BUSINESS" runat="server" Text="Branchenbuch" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label26" runat="server" Text="Eine Sammlung von Unternehmen in deiner Stadt....... "></asp:Label>
                                </p>
                            </div>

                            <div id ="div_annonce" class="span4 well label-important" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_ANNONCE" runat="server" Text="Kleinanzeigen" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label28" runat="server" Text="Verkaufen oder kaufen. Der regionale private Marktplatz"></asp:Label>
                                </p>
                            </div>

                            <div id ="div_shareconomeny" class="span4 well label-important" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_SWAP" runat="server" Text="Tauschen und Schenken" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label18" runat="server" Text="Die regionale Tausch- und Schenkbörse. Wirtschaft ohne Geld."></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div class="span1"></div>
                    </div>
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_startup" class="span4 well label-important" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_STARTUP" runat="server" Text="Gründungen und Neueröffnungen" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label19" runat="server" Text="Neue Unternehmen stellen sich vor"></asp:Label>
                                </p>
                            </div>
                            <div id ="div_jobmarket" class="span4 well label-important" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hylnk_jobmarket" runat="server" Text="Job-Börse" NavigateUrl="~/wbf_functs/jobs_search.aspx" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label30" runat="server" Text="Die Börse für Job-Börse. Job ausschreiben oder finden von Jobangeboten"></asp:Label>
                                </p>
                            </div>
                            <div class="span12"><br /><br /></div>
                        </div>
                        <div class="span1"></div>
                    </div>
                </div>
                <!-- %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 -->
                <div class="tab-pane" id="leisure">
                    <div class="row" >
                        <div class="span1"></div>
                        <div class="span10 well label-warning" style="color:White;height:150px;">
                            <h4>
                                <asp:Label ID="Label27" runat="server" Text="Freizeit"></asp:Label>
                            </h4>
                            <p>
                                <asp:Label ID="Label29" runat="server" Text="Freizeitangebote in deiner Region. Veranstalltungskalender für Konzerte und belibiege andere kulturelle Events."></asp:Label>
                                <br />
                                <asp:Label ID="Label31" runat="server" Text="Eine Informationsbörse für Hobbies und Haustierhalter"></asp:Label>
                                <br />
                            </p>
                        </div>
                        <div class="span1"></div>
                    </div>
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_events" class="span4 well label-warning" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_EVENT" runat="server" Text="Veranstaltungskalender" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label33" runat="server" Text="Veranstalltungen: Konzerte, Feste, Aufführungen....."></asp:Label>
                                </p>
                            </div>

                            <div id ="div_poi" class="span4 well label-warning" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_LOCATION" runat="server" Text="interessante Orte" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label35" runat="server" Text="Nennenswerte Orte, Treffpunkte, Dienststellen, Bankautomaten......"></asp:Label>
                                </p>
                            </div>

                            <div id ="div_pets" class="span4 well label-warning" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_PET" runat="server" Text="Haustiere" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label36" runat="server" Text="Alles zum Thema Haustiere. Entlaufen, zugelaufen, Tipps und Hilfen für Tierhalter"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div class="span1"></div>
                    </div>
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_hobbies" class="span4 well label-warning" style="cursor:pointer;color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_HOBBY" runat="server" Text="Hobbys" style="text-decoration:underline;color:White;"/>
                                </h4>
                                <asp:Label ID="Label37" runat="server" Text="Angebote zur Beschäftigung in der freien Zeit."></asp:Label>
                            </div>
                            <div class="span12"><br /><br /></div>
                        </div>
                        <div class="span1"></div>
                    </div>
                </div>
                <!-- %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 -->
                <div class="tab-pane" id="society">
                    <div class="row" >
                        <div class="span1"></div>
                            <div class="span10 well label-success" style="color:White;height:150px;">
                                <h4>
                                    <asp:Label ID="Label32" runat="server" Text="Gesellschaft"></asp:Label>
                                </h4>
                                <p>
                                    <asp:Label ID="Label34" runat="server" Text="Seine Umgebung mitgestalten und aktiv werden. Mitwirkung an der Politik im Wahlkreis."></asp:Label>
                                    <br />
                                    <asp:Label ID="Label38" runat="server" Text="Mitarbeit in lokalen Initiativen. Gemeinsam die Umwelt schonen."></asp:Label>
                                </p>
                            </div>
                        <div class="span1"></div>
                    </div>

                    <div class="row" >
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_initiative" class="span4 well label-success" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_INITIATIVE" runat="server" Text="Initiativen" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label39" runat="server" Text="Veranstalltungen: Konzerte, Feste, Aufführungen....."></asp:Label>
                                </p>
                            </div>

                            <div id ="div_democracy" class="span4 well label-success" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_DEMOCRACY" runat="server" Text="Mitmachdemokratie" style="text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label40" runat="server" Text="Politik gestalten mit der Erststimme in deinem Wahlkreis"></asp:Label>
                                </p>
                            </div>

                            <div id ="div_association" class="span4 well label-success" style="color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_ASSOCIATION" runat="server" Text="Vereine" style="cursor:pointer;text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label4726" runat="server" Text="Menschen mit einem gemeinsamen Ziel."></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div class="span1"></div>
                    </div>
                    <div class="row">
                        <div class="span1"></div>
                        <div class="span10">
                            <div id ="div_family" class="span4 well label-success" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_FAMILY" runat="server" Text="Für Familien" style="text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label4727" runat="server" Text="Spielplätze, Familienveranstaltungen, Seniorentreffen usw...."></asp:Label>
                                </p>
                            </div>
                            <div id ="div_drive" class="span4 well label-success" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_RIDE_SHARING" runat="server" Text="Fahrgemeinschaften" style="text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label41" runat="server" Text="Mitfahren, Fahrzeug teilen, Fahrgemeinschaft gründen"></asp:Label>
                                </p>
                            </div>
                            <div id ="div_flirt" class="span4 well label-success" style="cursor:pointer; color:White;height:120px;">
                                <h4>
                                    <asp:HyperLink ID="hyli_select_LONELY_HEARTS_AD" runat="server" Text="Kontaktanzeigen" style="text-decoration:underline;color:White;"/>
                                </h4>
                                <p>
                                    <asp:Label ID="Label4728" runat="server" Text="Der regionale Kontaktmarkt für einsame Herzen, Freundschaften und Erotik."></asp:Label>
                                </p>
                            </div>
                            <div class="span12"><br /><br /></div>
                        </div>
                        <div class="span1"></div>
                    </div>
                </div>
            </div>

            <!-- %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%% -->
            <!-- %%%%%%%%%%%%%%%  bottom of the dsplydiv_rubric   add hidden cancle button for projection-webforms                               %%%%%%%%%%%%%%% -->

            <div id="cancleProjector">

                <button id="btn_cancle_rubric" class="btn btn-large btn-danger span3" type="button">Abbrechen</button>

                <div class="span7"></div>

            </div>

            <div class="row"><br /></div>




            <!-- %%%%%%%%%%%%%%%                                                                                                                 %%%%%%%%%%%%%%% -->
            <!-- %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%%                 %%%%%%%%%%%%%%% -->

        </div>




        <!-- dsplydiv_subrubric ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
        <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
        <div id="dsplydiv_subrubric" style="display:none;">
            <div class="row well" id="listboxstairway">
                <div class="span12">
                    <h3>
                        <asp:Label ID="Label477729" runat="server" Text="Wähle eine Unterrubrik aus"></asp:Label>
                    </h3>

                    <div class="span12"><br /></div>


                    <div id="slct_div_0" style="display:none;">
                        <br />
                        <select id="lsbx_0" multiple="multiple" size="7" style="font-size:120%;width:93%;"></select>
                    </div>

                    <div id="slct_div_1" style="display:none;">
                        <br />
                        <select id="lsbx_1" multiple="multiple" size="7" style="font-size:120%;width:93%;"></select>
                    </div>

                    <div id="slct_div_2" style="display:none;">
                        <br />
                        <select id="lsbx_2" multiple="multiple" size="7" style="font-size:120%;width:93%;"></select>
                    </div>

                    <div id="slct_div_3" style="display:none;">
                        <br />
                        <select id="lsbx_3" multiple="multiple" size="7" style="font-size:120%;width:93%;"></select>
                    </div>

                    <div id="slct_div_4" style="display:none;">
                        <br />
                        <select id="lsbx_4" multiple="multiple" size="7" style="font-size:120%;width:93%;"></select>
                    </div>
                    <br /><br />

                    <button id="btn_back_to_rubric" class="btn btn-large btn-danger span3" type="button">Zurück</button>

                    <div id="div_for_projector">
                        <div class="span2">
                            <h5>
                                <asp:Label ID="lbl_dspl_rbrc" CssClass="pull-right" runat="server" Text="gewählte Rubrik:"></asp:Label>
                            </h5>
                        </div>
                        <div class="span2">
                            <asp:TextBox ID="txbx_itemname" runat="server" Enabled="false"></asp:TextBox>
                        </div>
                    </div>

                    <button id="btn_rubric_finished" class="btn btn-large btn-success span3 pull-right" type="button">Wählen</button>

                    <div class="row"><br /><br /></div>
                </div>
            </div>
        </div>




    </div>


    <!--    hidden area     ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########--> 
    <!--                    ########### ########### ########### ########### ########### ########### ########### ########### ########### ###########-->
    <div style="display:none; height:0px;">
        <!-- hidden text that is needed for the error-messages-->
        <asp:Label ID="lbl_error_text" runat="server" Text="error_text !"></asp:Label>

        <!-- the country-code of the user is used by javascript to make the geocoding by noatim -->
        <asp:Label ID="lbl_countrycode" runat="server" Text="de"></asp:Label>

        <!-- the user_id of the looged-in user. empty if nobody is logged in -->
        <asp:Label ID="lbl_userId" runat="server" Text=""></asp:Label>

        <!-- the hidden textbox stores the tag for a rubric -->
        <asp:TextBox ID="txbx_tagforitem" runat="server" EnableViewState="false"/>

        <!-- this lable is read by javascript to figure out what display-url will be used -->
        <asp:Label ID="lbl_display_url" runat="server" Text="de"></asp:Label>

        <!-- this lable is read by javascript to figure out what display-url will be used -->
        <asp:Label ID="lbl_already_visited" runat="server" Text=""></asp:Label>
    </div>




    <script type="text/javascript">
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // start webform js stuff
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        $(document).ready(function () {
            var displayUrl = $('#CoPlaBottom_lbl_display_url').text();      // define the url that will be used to dispaly the details in javascript
            projector = new MapProjector(displayUrl);                       // the map-projector handles the map via openlayers
            lstExtr = new ListExtractor('map', 2500, 75);                   // list-extractor manages the AJAX-load of data. initialie it loads some stuff from the server
            // lstExtr = new ListExtractor('map', 4, 2);                    // list-extractor manages the AJAX-load of data. initialie it loads some stuff from the server

            // datepicker from jquery_ui
            $("#CoPlaBottom_txbx_timeFrom").datepicker($.datepicker.regional["de"]);
            $("#CoPlaBottom_txbx_timeTo").datepicker($.datepicker.regional["de"]);

            // click function for start display with the map-projector
            $('#startSearch').click(function () {
                $('#srchDialg').modal('hide');
                // start the marker-positioning
                console.log('start customized search');
                lstExtr.loadInitial();
                lstExtr.clientPageSend();

                // funfuckers : center the country in the map if no city was selected
                // added 16.09.2013
                if (projector.map != undefined) {
                    var country = document.getElementById("CoPlaBottom_sel_country").options[c.selectedIndex].value;
                    var city = $("#CoPlaBottom_txbx_city").val();
                    var postcode = $("#CoPlaBottom_txbx_postCode").val();

                    if ((city == '') && (postcode == '')) {
                        // DEFINE long, lat, zoom
                        var geoDict = {};
                        geoDict['0'] = [50.0, 10.0, 4];
                        geoDict['DE'] = [51.0, 10.0, 6];
                        geoDict['AT'] = [48.0, 14.0, 7];
                        geoDict['CH'] = [47.0, 8.0, 8];
                        geoDict['LI'] = [47.0, 10.0, 9];
                        geoDict['BE'] = [51.0, 4.8, 8];
                        geoDict['NL'] = [52.0, 6.0, 8];

                        var tmpCntry = geoDict[country];
                        var cityLon = tmpCntry[1];
                        var cityLat = tmpCntry[0];
                        var zoom = tmpCntry[2];

                        var proj4326 = new OpenLayers.Projection("EPSG:4326");
                        var projmerc = new OpenLayers.Projection("EPSG:900913");
                        var lonlat = new OpenLayers.LonLat(cityLon, cityLat).transform(proj4326, projmerc);
                        projector.map.setCenter(lonlat);
                        projector.map.zoomTo(zoom);

                        return;
                    }
                }
            });

            // click function for deleting all setings in the modal search-parameter-dialog
            $('#deleteSearch').click(function () {
                lstExtr.clearSearchDialog();
                return false;
            });

            // open the list with THE current search-param in a new tab/window
            $('.btn').tooltip();

            $('#open_list').click(function () {
                lstExtr.getUrlParams();
                var param = lstExtr.prepareUrl();
                // alert(param);
                var url = './projector_debateList.aspx' + param;
                // var win = window.open(url, '_blank');
                var win = window.open(nejobaUrl(url), '_blank');

                win.focus();
            });

            //open the bookmark-dialog. also helpfull for social networx
            $('#show_bookmark').click(function () {
                alert('bkmrk clickes');
                lstExtr.showBookmark();
            });

            // open help only on first visit 
            //            if ($('#CoPlaBottom_lbl_already_visited').text() != 'YES') {
            //                $('#shortdescription').modal('show');
            //            }

            //
            //  16.09.2013 bervie
            //
            // if a country is set the textfields should not be disabeled. a user is logged in !
            //
            var c = document.getElementById("CoPlaBottom_sel_country");
            if ('0' != c.options[c.selectedIndex].value) {
                // alert('c.options[c.selectedIndex].value : ' + c.options[c.selectedIndex].value);
                $("#CoPlaBottom_txbx_postCode").removeAttr('disabled');
                $("#CoPlaBottom_txbx_city").removeAttr('disabled');
                return;
            }

        });

    </script>
</asp:Content>


