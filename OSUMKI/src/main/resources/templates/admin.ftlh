<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Панель администратора</h1>
    <hr>
    <form method="get" action="/admin" style="width: 90%; margin: 0 auto;">
        <div class="form-row">
            <div style="margin-bottom: 10px" class="form-group loop">
                <input type="text" name="searchUser" placeholder="Поиск"
                       <#if searchUser??>value="${searchUser}"</#if> class="form-control" id="searchUser">
                <button type="submit" class="search-button"><i class="fas fa-search"></i></button>
            </div>
        </div>
    </form>
    <table class="table table-hover table-dark" style="width: 90%; margin: 0 auto;">
        <tr>
            <th>Имя</th>
            <th>Email</th>
            <th>Номер телефона</th>
            <th>Активность</th>
            <th>Роли</th>
            <th>Удалить</th>
            <th>Почта</th>
            <th>Редактирование</th>
            <th>Подробная информация</th>
        </tr>
        <#list users as user>
            <tr>
                <th>${user.name}</th>
                <th>${user.email}</th>
                <th>${user.phoneNumber}</th>
                <th>
                    <form action="/admin/user/ban/${user.id?c}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" <#if user.active>value="Забанить" <#else>value="Разбанить"</#if>>
                    </form>
                </th>
                <th><#list user.roles as role>${role}</#list></th>
                <th>
                    <form action="/admin/user/delete/${user.id?c}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Удалить">
                    </form>
                </th>
                <th>
                    <form action="/admin/user/confirmEmail/${user.id?c}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" <#if !user.confirmedEmail>value="Подтвердить" <#else>value="Отменить подтверждение"</#if>>
                    </form>
                </th>
                <th><a href="/admin/user/edit/${user.id?c}">Редактирование</a></th>
                <th><a href="/user/${user.id?c}">Подробная информация</a></th>
            </tr>
        <#else>
            <h3 style="text-align: center">Пользователей нет</h3>
        </#list>
    </table>
</@t.template>