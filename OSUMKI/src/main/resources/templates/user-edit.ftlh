<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Редактирование пользователя "${userEdit.name}"</h1>
    <hr>
    <div style="display: flex; flex-direction: column; align-items: center; text-align: center;">
        <#if userEdit.isAdmin()>
            <img src="/static/images/adminAvatar.png"
                 style="border: 2px solid black; border-radius: 20px;" height="120" width="120" alt="АдминПрофиль">
        <#elseif userEdit.isModerator()>
            <img src="/static/images/moderatorAvatar.png"
                 style="border: 2px solid black; border-radius: 20px;" height="120" width="120" alt="модераторПрофиль">
        <#else>
            <div style="display: flex; justify-content: center; align-items: center; font-family: 'Marck Script', serif; background-color: white; border: 2px solid black; border-radius: 20px; width: 120px; height: 120px;">
                <div style="text-align: center; line-height: 120px; font-size: 60px; user-select: none;">
                    ${userEdit.name?substring(0, 1)}
                </div>
            </div>
        </#if>
        <br><br>
        <form action="/admin/user/edit" method="post"
              style="display: flex; flex-direction: column; align-items: center;">
            <div style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 20px;">
                <label for="name">Имя:</label>
                <input type="text" id="name" name="name" value="${userEdit.name}" required
                       style="border: 2px solid black; border-radius: 8px;">
            </div>
            <#if !userEdit.isAdmin()>
                <div style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 20px;">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${userEdit.email}" required
                           style="border: 2px solid black; border-radius: 8px;">
                </div>
            </#if>
            <div style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 20px;">
                <label for="phoneNumber">Номер телефона:</label>
                <input type="text" class="data-tel-input" id="phoneNumber" name="phoneNumber"
                       value="${userEdit.phoneNumber}" required style="border: 2px solid black; border-radius: 8px;">
            </div>
            <#if !userEdit.isAdmin()>
                <div style="display: flex; flex-direction: column; align-items: flex-start; margin-bottom: 20px;">
                    <#list roles as role>
                        <label>
                            <input class="rolesClass" type="checkbox" onclick="clickCheckBox(event)" name="${role}" ${userEdit.roles?seq_contains(role)?string("checked", "")}>${role}
                        </label>
                    </#list>
                </div>
            </#if>
            <div style="display: flex; flex-direction: column; align-items: flex-start; margin-top: 20px; margin-bottom: 20px">
                <label for="verificationCode">Код подтверждения:</label>
                <input type="text" id="verificationCode" name="verificationCode" value="${userEdit.verificationCode}"
                       required style="border: 2px solid black; border-radius: 8px;">
            </div>
            <input type="hidden" value="${userEdit.id?c}" name="userId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <button type="submit" class="btn btn-dark">Сохранить</button>
        </form>
    </div>
    <script>
        const clickCheckBox = (e) => {
            const checkboxes = document.getElementsByClassName("rolesClass");
            for (let i of checkboxes) {
                i.checked = false;
            }
            e.target.checked = true;
        };

        function updateValue(id) {
            var checkbox = document.getElementById(id);

            // Если чекбокс выбран, устанавливаем значение "true", иначе "false"
            checkbox.value = checkbox.checked ? "true" : "false";
        }
    </script>
</@t.template>
