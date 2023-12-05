<#import "blocks/template.ftlh" as t>
<@t.template user>

    <div class="container" style="width: 25%; min-width: 300px">
        <h1 style="text-align: center">Регистрация</h1>
        <hr>
        <form action="/registration" method="post" id="registrationForm">
            <div class="form-group password-container">
                <label for="name">Имя пользователя</label>
                <div style="height: fit-content; position: relative;">
                    <input type="text" class="form-control" required id="name" name="name">
                    <span class="info-toggle" id="dataInfoNameMessage" onclick="toggleInfo('NameMessage')"
                          style="position: absolute; top: 19px"></span>
                    <div id="infoNameMessage" class="infoNameMessage">
                        Введите уникальное имя пользователя (от 5 символов). P.S. Нельзя использовать пробел.
                    </div>
                    <div id="nameErrorMessage" class="error-message-text"></div>
                </div>
            </div>
            <div class="form-group password-container">
                <label for="email">Электронная почта</label>
                <div style="height: fit-content; position: relative;">
                    <input type="email" class="form-control" id="email" required name="email">
                    <span id="dataInfoEmailMessage" class="info-toggle" onclick="toggleInfo('EmailMessage')"
                          style="position: absolute; top: 19px"></span>
                    <div id="infoEmailMessage" class="infoEmailMessage">
                        Введите свою действующую почту, вместе с @. Позже на нее отправим код.
                    </div>
                    <div id="emailErrorMessage" class="error-message-text"></div>
                </div>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Номер телефона</label>
                <input type="tel" class="form-control data-tel-input" id="phoneNumber" required name="phoneNumber"
                       maxlength="18"/>
                <div id="phoneErrorMessage" class="error-message-text"></div>
            </div>

            <div class="form-group password-container">
                <label for="password">Пароль</label>
                <div style="height: fit-content; position: relative;">
                    <input type="password" class="form-control" id="password" required
                           name="password">
                    <span class="password-toggle" onclick="togglePasswordVisibility()"
                          style="position: absolute; top: 19px"></span>
                    <span id="dataInfoPasswordMessage" class="info-toggle" onclick="toggleInfo('PasswordMessage')"
                          style="position: absolute; top: 19px"></span>
                    <div id="infoPasswordMessage" class="infoPasswordMessage">
                        Минимум 8 символов. P.S. Нельзя использовать пробел.
                    </div>
                    <div id="passwordErrorMessage" class="error-message-text"></div>
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" id="registrationButton" style="width: 100%; margin-top: 10px;" class="btn btn-dark"
                    disabled>Зарегистрироваться
            </button>
        </form>
        <#if errorMessage??>
            <div id="errorMessage" class="error-message"
                 style="display: none; background-color: white; border: solid 1px black; border-radius: 5px; position: fixed; z-index: 10;
                 top: 100px; left: calc(100% - 320px); padding: 20px; height: fit-content; width: 260px;">
            </div>
            <script>
                const errorMessage = "${errorMessage}";
                showErrorMessage(errorMessage);
            </script>
        </#if>
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

        function showErrorMessage(message) {
            const errorMessage = document.getElementById("errorMessage");
            errorMessage.innerText = message;
            errorMessage.style.display = "flex";
            setTimeout(function () {
                errorMessage.style.display = "none";
            }, 3000);
        }

        function toggleInfo(inputId) {
            const infoBox = document.getElementById(`info` + inputId);
            const infoToggle = document.getElementById(`dataInfo` + inputId);
            let boxCheck, toggleCheck
            boxCheck = infoBox.style.display === 'flex';
            toggleCheck = infoToggle.style.opacity === '0.5';

            let infoBoxes = []
            infoBoxes.push(document.getElementById('infoEmailMessage'))
            infoBoxes.push(document.getElementById('infoNameMessage'))
            infoBoxes.push(document.getElementById('infoPasswordMessage'))
            let infoToggles = []
            infoToggles.push(document.getElementById('dataInfoEmailMessage'))
            infoToggles.push(document.getElementById('dataInfoNameMessage'))
            infoToggles.push(document.getElementById('dataInfoPasswordMessage'))
            for (let i of infoBoxes) {
                i.style.display = 'none'
            }
            for (let i of infoToggles) {
                i.style.opacity = '1'
            }

            if (boxCheck) infoBox.style.display = 'none'
            else infoBox.style.display = 'flex'

            if (toggleCheck) infoToggle.style.opacity = '1'
            else infoToggle.style.opacity = '0.5'
        }

        document.addEventListener("DOMContentLoaded", function () {
            const nameField = document.getElementById("name");
            const nameError = document.getElementById("nameErrorMessage");
            const emailField = document.getElementById("email");
            const emailError = document.getElementById("emailErrorMessage");
            const phoneField = document.getElementById("phoneNumber");
            const phoneError = document.getElementById("phoneErrorMessage");
            const passwordField = document.getElementById("password");
            const passwordError = document.getElementById("passwordErrorMessage");
            const registrationForm = document.getElementById("registrationForm");

            nameField.addEventListener("blur", function () {
                nameErrorText();
                validateName();
                canEnableRegistrationButton();
            });

            emailField.addEventListener("blur", function () {
                emailErrorText();
                validateEmail();
                canEnableRegistrationButton();
            });

            phoneField.addEventListener("blur", function () {
                phoneErrorText();
                validatePhone();
                canEnableRegistrationButton();
            });

            passwordField.addEventListener("blur", function () {
                passwordErrorText();
                validatePassword();
                canEnableRegistrationButton();
            });

            registrationForm.addEventListener("submit", function (e) {
                if (!validateName() || !validateEmail() || !validatePhone() || !validatePassword()) {
                    e.preventDefault(); // Остановка отправки формы, если есть ошибки
                }
            });

            function validateName() {
                const nameValue = nameField.value.trim();
                if (nameValue.length < 5) {
                    return false;
                } else if (nameValue.trim() !== nameValue) {
                    return false;

                } else {
                    return fetch("/check-username?name=" + encodeURIComponent(nameValue))
                        .then(response => response.text())
                        .then(data => {
                            console.log("Полученный ответ:", data); // Вывести полученные данные в консоль
                            return JSON.parse(data);
                        })
                        .then(parsedData => {
                            if (parsedData.exists) {
                                nameError.textContent = "Имя пользователя занято";
                                nameField.classList.add("error");
                                return false;
                            }
                            return true; // Возвращаем true только если проверка прошла успешно
                        })
                        .catch(error => {
                            console.error("Произошла ошибка:", error);
                            return true; // Возвращаем true в случае ошибки
                        });
                }
            }

            function nameErrorText() {
                console.log('yes')
                const nameValue = nameField.value.trim();
                nameError.textContent = "";
                nameField.classList.remove("error");

                if (nameValue.length < 5) {
                    nameError.textContent = "Имя пользователя слишком короткое";
                    nameField.classList.add("error");
                    return false;
                } else if (nameValue.trim() !== nameValue) {
                    nameError.textContent = "Обнаружены пробелы";
                    nameField.classList.add("error");
                    return false;
                }
            }

            function validatePassword() {
                const passwordValue = passwordField.value.trim();
                console.log(passwordValue)
                if (passwordValue.length < 8) {
                    return false;
                } else if (passwordValue !== passwordField.value) {
                    return false;
                } else {
                    return true;
                }
            }

            function passwordErrorText() {
                console.log('yes')
                const passwordValue = passwordField.value.trim();
                passwordError.textContent = "";
                passwordField.classList.remove("error");

                if (passwordValue.length < 8) {
                    passwordError.textContent = "Пароль слишком короткий";
                    passwordField.classList.add("error");
                    return false;
                } else if (passwordValue.trim() !== passwordValue) {
                    passwordError.textContent = "Обнаружены пробелы";
                    passwordField.classList.add("error");
                    return false;
                }
            }

            function emailValidation(value) {
                // DO NOT DELETE NEXT LINE!!!
                // eslint-disable-next-line
                let txt = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return txt.test(value);
            }

            function validateEmail() {
                const emailValue = emailField.value.trim();

                if (!emailValidation(emailValue)) {
                    return false;
                } else {
                    return fetch("/check-mail?mail=" + encodeURIComponent(emailValue))
                        .then(response => response.text())
                        .then(data => {
                            const parsedData = JSON.parse(data);
                            if (parsedData.exists) {
                                emailError.textContent = "Email уже занят";
                                emailField.classList.add("error");
                                return false;
                            }
                            return true;
                        })
                        .catch(error => {
                            console.error("Произошла ошибка:", error);
                            return true;
                        });
                }
            }

            function emailErrorText() {
                const emailValue = emailField.value.trim();
                emailError.textContent = "";
                emailField.classList.remove("error");

                if (!emailValidation(emailValue)) {
                    emailError.textContent = "Некорректный email";
                    emailField.classList.add("error");
                    return false;
                }
            }

            function validatePhone() {
                const phoneField = document.getElementById("phoneNumber");
                let phoneValue = phoneField.value.trim();
                if (phoneValue.length < 17) {
                    return false;
                }
                console.log("default " + phoneValue);
                return fetch("/check-phone?phone=" + encodeURIComponent(phoneValue))
                    .then(response => response.text())
                    .then(data => {
                        const parsedData = JSON.parse(data);
                        if (parsedData.exists) {
                            phoneField.classList.add("error");
                            return false;
                        } else {
                            if (phoneValue.startsWith("+7")) {
                                phoneValue = '8' + phoneValue.slice(2);
                            } else if (phoneValue.startsWith("8")) {
                                phoneValue = '+7' + phoneValue.slice(1);
                            }
                        }

                        console.log("8gg " + phoneValue)
                        return fetch("/check-phone?phone=" + encodeURIComponent(phoneValue))
                            .then(response => response.text())
                            .then(data => {
                                const parsedData = JSON.parse(data);
                                if (parsedData.exists) {
                                    phoneField.classList.add("error");
                                    return false;
                                }
                                return true;
                            })
                            .catch(error => {
                                console.error("Произошла ошибка:", error);
                                return false;
                            });
                    })
                    .catch(error => {
                        console.error("Произошла ошибка:", error);
                        return false;
                    });
            }

            function phoneErrorText() {
                const phoneField = document.getElementById("phoneNumber");
                let phoneValue = phoneField.value.trim();
                phoneError.textContent = "";
                phoneField.classList.remove("error");
                if (phoneValue.length < 17) {
                    phoneError.textContent = "Номер слишком короткий";
                    phoneField.classList.add("error");
                    return false;
                }
                console.log("default " + phoneValue);
                return fetch("/check-phone?phone=" + encodeURIComponent(phoneValue))
                    .then(response => response.text())
                    .then(data => {
                        const parsedData = JSON.parse(data);
                        if (parsedData.exists) {
                            phoneError.textContent = "Номер телефона уже занят";
                            phoneField.classList.add("error");
                            return false;
                        } else {
                            if (phoneValue.startsWith("+7")) {
                                phoneValue = '8' + phoneValue.slice(2);
                            } else if (phoneValue.startsWith("8")) {
                                phoneValue = '+7' + phoneValue.slice(1);
                            }
                        }

                        console.log("8gg " + phoneValue)
                        return fetch("/check-phone?phone=" + encodeURIComponent(phoneValue))
                            .then(response => response.text())
                            .then(data => {
                                const parsedData = JSON.parse(data);
                                if (parsedData.exists) {
                                    phoneError.textContent = "Номер телефона уже занят";
                                    phoneField.classList.add("error");
                                    return false;
                                }

                                // Если обе проверки не прошли, возвращаем false
                                return true;
                            })
                            .catch(error => {
                                console.error("Произошла ошибка:", error);
                                return false;
                            });
                    })
                    .catch(error => {
                        console.error("Произошла ошибка:", error);
                        return false;
                    });
            }

            function canEnableRegistrationButton() {
                const nameValid = validateName();
                const emailValid = validateEmail();
                const passwordValid = validatePassword();
                validatePhone().then(phoneValid => {
                    const registrationButton = document.getElementById("registrationButton");
                    registrationButton.disabled = !(nameValid && emailValid && phoneValid && passwordValid);
                });
            }

        });

    </script>
</@t.template>