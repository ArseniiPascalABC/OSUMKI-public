<#import "blocks/template.ftlh" as t>
<@t.template user>

    <div class="container" style="width: 25%; min-width: 300px">
        <h1 style="text-align: center">Подтверждение почты</h1>
        <hr>
        <form action="/confirm" method="post">
            <div class="form-group">
                <label for="confirmationCode">Код подтверждения</label>
                <input type="text" class="form-control" required id="confirmationCode" name="confirmationCode">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" style="width: 100%; margin-top: 5%" class="btn btn-dark">Подтвердить</button>
        </form>
        <#if errorMessage??>
            <div id="errorMessage" class="error-message" style="display: none; background-color: white; border: solid 1px black; border-radius: 5px; position: fixed; z-index: 10; top: 100px; left: calc(100% - 320px); padding: 20px; height: fit-content; width: 260px;"></div>
            <script>
                function showErrorMessage(message) {
                    const errorMessage = document.getElementById("errorMessage");
                    errorMessage.innerText = message;
                    errorMessage.style.display = "flex";
                    setTimeout(function() {
                        errorMessage.style.display = "none";
                    }, 3000);
                }
                const errorMessage = "${errorMessage}";
                showErrorMessage(errorMessage);
            </script>
        </#if>
    </div>

</@t.template>