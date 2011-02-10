﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="YafHeader.ascx.cs" Inherits="YAF.Controls.YafHeader" %>
<%@ Import Namespace="YAF.Core" %>
<%@ Import Namespace="YAF.Types.Constants" %>
<%@ Import Namespace="YAF.Utils" %>
<%@ Import Namespace="YAF.Types.Interfaces" %>
<%@ Import Namespace="YAF.Controls" %>
<%@ Import Namespace="YAF.Utils.Helpers" %>
<div id="yafheader">
    <% if (this.PageContext.IsGuest)
       {%>
    <div class="guestUser">
        <%=this.GetText("TOOLBAR", this.PageContext.IsGuest ? "WELCOME_GUEST" : "LOGGED_IN_AS").FormatWith("&nbsp;")%>
    </div>
    <%
       }%>
    <div class="outerMenuContainer">
        <div class="menuMyContainer">
            <ul class="menuMyList">
                <% if (!this.PageContext.IsGuest)
                   {%>
                <li class="menuMy"><a target='_top' title="<%=this.GetText("TOOLBAR", "MYPROFILE")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.cp_profile) %>">
                    <%=this.GetText("TOOLBAR", "MYPROFILE")%></a> </li>
                <%
                   }%>
                <% if (!this.PageContext.IsGuest && this.PageContext.BoardSettings.AllowPrivateMessages)
                   {%>
                <li class="menuMy"><a target='_top' title="<%=this.GetText("TOOLBAR", "INBOX")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.cp_pm)%>">
                    <%=this.GetText("TOOLBAR", "INBOX")%>
                </a>
                    <%
                       if (this.PageContext.UnreadPrivate > 0)
                       {%>
                    <span class="unread">
                        <%=
                     this.GetText("TOOLBAR", "NEWPM").FormatWith(
                       this.PageContext.UnreadPrivate)%></span>
                    <%
                   }%>
                </li>
                <%
                   }
                   if (!this.PageContext.IsGuest && YafContext.Current.BoardSettings.EnableBuddyList && this.PageContext.UserHasBuddies)
                   {%>
                <li class="menuMy"><a target='_top' title="<%=this.GetText("TOOLBAR", "BUDDIES")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.cp_editbuddies)%>">
                    <%= this.GetText("TOOLBAR", "BUDDIES")%></a>
                    <%
                       if (this.PageContext.PendingBuddies > 0)
                       {%>
                    <span class="unread">
                        <%=
                           this.GetText("TOOLBAR", "BUDDYREQUEST").FormatWith(
                             this.PageContext.PendingBuddies)%></span>
                    <% } %>
                </li>
                <% } %>
                <%
                    if (!this.PageContext.IsGuest && YafContext.Current.BoardSettings.EnableAlbum && (this.PageContext.UsrAlbums > 0 || this.PageContext.NumAlbums > 0))
                    {%>
                <li class="menuMy"><a target='_top' title="<%=this.GetText("TOOLBAR", "MYALBUMS")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.albums, "u={0}", this.PageContext.PageUserID)%>">
                    <%=this.GetText("TOOLBAR", "MYALBUMS")%></a> </li>
                <%
                    }                    
                %>
                <%if (!this.PageContext.IsGuest)
                  {%>
                <li class="menuMy"><a target='_top' title="<%=this.GetText("TOOLBAR", "MYTOPICS")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.mytopics) %>">
                    <%=this.GetText("TOOLBAR", "MYTOPICS")%></a> </li>
                <%
                  }%>
                <%
                    if (!this.PageContext.IsGuest && !YAF.Classes.Config.IsAnyPortal && YAF.Classes.Config.AllowLoginAndLogoff)
                    {%>
                <li class="menuAccount">
                    <asp:LinkButton ID="LogOutButton" runat="server" OnClick="LogOutClick"><%=this.GetText("TOOLBAR", "LOGOUT")%></asp:LinkButton></li>
                <%
                    }    
                %>
            </ul>
        </div>
        <% if (!this.PageContext.IsGuest)
           {%>
        <div class="loggedInUser">
            <%=this.GetText("TOOLBAR", "LOGGED_IN_AS").FormatWith("&nbsp;")%>
            <%= new UserLink()
{
    ID = "UserLoggedIn",
    Visible = !this.PageContext.IsGuest,
    UserID =  this.PageContext.PageUserID,
    CssClass = "currentUser"
    ,
}.RenderToString() %>
        </div>
        <%
           }%>
        <div class="menuContainer">
            <ul class="menuList">
                <li class="menuGeneral"><a target='_top' title="<%=this.GetText("DEFAULT", "FORUM")%>"
                     rel="nofollow" href="<%=YafBuildLink.GetLink(ForumPages.forum) %>">
                    <%=this.GetText("DEFAULT", "FORUM")%></a> </li>
                <%if (this.PageContext.IsGuest)
                  {%>
                <li class="menuGeneral"><a target='_top' title="<%=this.GetText("TOOLBAR", "ACTIVETOPICS")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.mytopics) %>">
                    <%=this.GetText("TOOLBAR", "ACTIVETOPICS")%></a> </li>
                <%
                  }%>
                <%
                    if (this.Get<IPermissions>().Check(this.PageContext.BoardSettings.ExternalSearchPermissions) || this.Get<IPermissions>().Check(this.PageContext.BoardSettings.SearchPermissions))
                    {%>
                <li class="menuGeneral"><a title="<%=this.GetText("TOOLBAR", "SEARCH")%>"
                    rel="nofollow" href="<%=YafBuildLink.GetLink(ForumPages.search)%>">
                    <%=this.GetText("TOOLBAR", "SEARCH")%></a> </li>
                <%
                    }                    
                %>
                <%
                    if (this.Get<IPermissions>().Check(this.PageContext.BoardSettings.MembersListViewPermissions))
                    {%>
                <li class="menuGeneral"><a title="<%=this.GetText("TOOLBAR", "MEMBERS")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.members)%>">
                    <%=this.GetText("TOOLBAR", "MEMBERS")%></a> </li>
                <%
                    }                    
                %>
                    <%
                    if (this.PageContext.BoardSettings.ShowTeam)
                    {%>
                <li class="menuGeneral"><a title="<%=this.GetText("TOOLBAR", "TEAM")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.team)%>">
                    <%=this.GetText("TOOLBAR", "TEAM")%></a> </li>
                <%
                    }                    
                %>
                <%
                    if (this.PageContext.BoardSettings.ShowHelp)
                    {%>
                <li class="menuGeneral"><a target='_top' title="<%=this.GetText("TOOLBAR", "HELP")%>"
                    rel="help" href="<%=YafBuildLink.GetLink(ForumPages.help_index) %>">
                    <%=this.GetText("TOOLBAR", "HELP")%></a> </li>
                <%
                    }                    
                %>
                <%
                    if (this.PageContext.IsGuest && !YAF.Classes.Config.IsAnyPortal && YAF.Classes.Config.AllowLoginAndLogoff)
                    {
                        string returnUrl = this.GetReturnUrl().IsSet()
                                             ? "ReturnUrl={0}".FormatWith(
                                               this.PageContext.BoardSettings.UseSSLToLogIn
                                                 ? this.GetReturnUrl().Replace("http:", "https:")
                                                 : this.GetReturnUrl())
                                             : string.Empty;

                        if (this.PageContext.BoardSettings.UseLoginBox && !(YafContext.Current.Get<IYafSession>().UseMobileTheme ?? false))
                        {%>
                <li class="menuAccount"><a title="<%=this.GetText("TOOLBAR", "LOGIN")%>"
                    class="LoginLink" rel="nofollow" href="#">
                    <%=this.GetText("TOOLBAR", "LOGIN")%>
                </a></li>
                <%
                        }
                        else
                        {%>
                <li class="menuAccount"><a title="<%=this.GetText("TOOLBAR", "LOGIN")%>"
                     rel="nofollow"  href="<%= YafBuildLink.GetLink(ForumPages.login, returnUrl) %>">
                    <%=this.GetText("TOOLBAR", "LOGIN")%></a></li>
                <%}%>
                <%
                    }%>
                <%
                    if (this.PageContext.IsGuest && !this.PageContext.BoardSettings.DisableRegistrations && !YAF.Classes.Config.IsAnyPortal)
                    {%>
                <li class="menuAccount"><a title="<%=this.GetText("TOOLBAR", "REGISTER")%>"
                     rel="nofollow" href="<%=this.PageContext.BoardSettings.ShowRulesForRegistration
                                                        ? YafBuildLink.GetLink(ForumPages.rules)
                                                        : (!this.PageContext.BoardSettings.UseSSLToRegister ? YafBuildLink.GetLink(ForumPages.register) : YafBuildLink.GetLink(ForumPages.register).Replace("http:", "https:")) %>">
                    <%=this.GetText("TOOLBAR", "REGISTER")%></a></li>
                <%
                    }%>
            </ul>
            <%
                if (this.PageContext.BoardSettings.ShowQuickSearch && this.Get<IPermissions>().Check(this.PageContext.BoardSettings.ExternalSearchPermissions) || this.PageContext.BoardSettings.ShowQuickSearch && this.Get<IPermissions>().Check(this.PageContext.BoardSettings.SearchPermissions))
                {%>
            <div id="quickSearch" class="QuickSearch" runat="server">
                <asp:TextBox ID="searchInput" runat="server"></asp:TextBox>&nbsp;
                <asp:LinkButton ID="doQuickSearch" onkeydown="" runat="server" CssClass="QuickSearchButton"
                    OnClick="QuickSearchClick"></asp:LinkButton>
            </div>
            <%
                }
                if (this.PageContext.IsAdmin)
                {%>
            <ul class="menuAdminList">
                <li class="menuAdmin"><a target='_top' title="<%=this.GetText("TOOLBAR", "ADMIN")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.admin_admin) %>">
                    <%=this.GetText("TOOLBAR", "ADMIN")%></a> </li>
                <%
             }

             if (this.PageContext.IsHostAdmin)
             {%>
                <li class="menuAdmin"><a target='_top' title="<%=this.GetText("TOOLBAR", "HOST")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.admin_hostsettings) %>">
                    <%=this.GetText("TOOLBAR", "HOST")%></a> </li>
                <%
                }%>
                <%if (this.PageContext.IsModerator || this.PageContext.IsForumModerator)
                  {%>
                <li class="menuAdmin"><a target='_top' title="<%=this.GetText("TOOLBAR", "MODERATE")%>"
                    href="<%=YafBuildLink.GetLink(ForumPages.moderate_index) %>">
                    <%=this.GetText("TOOLBAR", "MODERATE")%></a> </li>
            </ul>
            <% 
                  }%>
        </div>
    </div>
    <div id="yafheaderEnd">
    </div>
</div>
