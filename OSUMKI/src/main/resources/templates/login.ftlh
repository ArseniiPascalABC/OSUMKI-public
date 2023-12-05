<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="container">
        <h1 style="text-align: center">Авторизация</h1>
        <hr>
        <form action="/login " method="post">
            <div class="form-group">
                <label for="email">Электронная почта</label>
                <input type="email" class="form-control"
                       id="email" name="username">
                <div id="email" class="invalid-feedback">
                    Неверная электронная почта
                </div>
            </div>
            <div class="form-group password-container">
                <label for="password">Пароль</label>
                <div style="height: fit-content; position: relative;">
                    <input type="password" style="margin-bottom: 10px" class="form-control"
                           id="password" name="password">
                    <span class="password-toggle login" onclick="togglePasswordVisibility()"
                          style="position: absolute;"></span>
                </div>
                <script>
                    function togglePasswordVisibility() {
                        const passwordField = document.getElementById('password');
                        const passwordToggle = document.querySelector('.password-toggle');

                        if (passwordField.type === 'password') {
                            passwordField.type = 'text';
                            passwordToggle.style.backgroundImage = "url('/static/images/eyeOpen.png')";
                        } else {
                            passwordField.type = 'password';
                            passwordToggle.style.backgroundImage = "url('/static/images/eyeHide.png')";
                        }
                    }
                </script>
                <div id="password" class="invalid-feedback">
                    Неверный пароль
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" style="width: 100%" class="btn btn-dark">Войти</button>
        </form>
        <#if errorMessage??>
            <div id="errorMessage" class="error-message"
                 style="display: none; background-color: white; border: solid 1px black; border-radius: 5px; position: fixed; z-index: 10; top: 100px; left: calc(100% - 320px); padding: 20px; height: fit-content; width: 260px;">
                <script>
                    function showErrorMessage(message) {
                        const errorMessage = document.getElementById("errorMessage");
                        errorMessage.innerText = message;
                        errorMessage.style.display = "flex";
                        setTimeout(function () {
                            errorMessage.style.display = "none";
                        }, 3000);
                    }

                    const errorMessage = "${errorMessage}";
                    showErrorMessage(errorMessage);
                </script>
            </div>
        </#if>

<#--        <#if >-->
<#--            <script>-->
<#--                // Проверьте, есть ли значение 'successMessage' и оно не равно false-->
<#--                const successMessage = '${successMessage}';-->
<#--                console.log(successMessage + " successsss")-->
<#--                if (successMessage) {-->
<#--                    showSuccessMessage(successMessage);-->
<#--                }-->

<#--                function showSuccessMessage(message) {-->
<#--                    const errorMessage = document.getElementById("errorMessage");-->
<#--                    errorMessage.innerText = message;-->
<#--                    errorMessage.style.display = "flex";-->
<#--                    setTimeout(function () {-->
<#--                        errorMessage.style.display = "none";-->
<#--                    }, 3000);-->
<#--                }-->
<#--            </script>-->
<#--        <#else>-->
<#--            <#assign successMessage = false>-->
<#--        </#if>-->
        <hr>
        <h5>Нет аккаунта в OSUMKI? <a href="/registration">Зарегистрируйся!</a></h5>
    </div>
</@t.template>