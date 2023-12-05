<#import "blocks/template.ftlh" as t>
<@t.template userByPrincipal>
    <h1 style="text-align: center">Информация о пользователе</h1>
    <hr>
    <div style="text-align: center">
        <#if user.isAdmin()>
            <img src="/static/images/adminAvatar.png"
                 style="border:2px solid black; border-radius: 20px" height="120" width="120" alt="АдминПрофиль">
        <#elseif user.isModerator()>
            <img src="/static/images/moderatorAvatar.png"
                 style="border:2px solid black; border-radius: 20px" height="120" width="120" alt="модераторПрофиль">
        <#else>
            <div style="width: 100%; display: flex; justify-content: center">
                <div style="font-family: 'Marck Script', serif; background-color: white; border: 2px solid black; border-radius: 20px; width: 120px; height: 120px;>
                text-align: center; line-height: 120px; font-size: 60px; user-select: none;">
                    ${user.name?substring(0, 1)}
                </div>
            </div>
        </#if>
        <br>
        <br>
        <h2>${user.name}</h2>
        <br>
        Номер телефона: <b>${user.phoneNumber}</b>
        <br>
        Email: <b>${user.email}</b>
        <br>
        Активность: <b>${user.active?string}</b>
        <br>
        Дата регистрации: <b>${user.dateOfCreated}</b>
        <br>
    </div>
    <br>
    <hr>
</@t.template>