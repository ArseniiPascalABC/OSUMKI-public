<#macro template user>
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="/static/css/style.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
              crossorigin="anonymous">
        <title>O!SUMKI</title>
        <link rel="preload" href="/static/images/Frame_13OSUMKI_WEB.jpg" as="image">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="icon" type="image/png" href="/static/images/icon.png">
        <div class="loading-spinner-container" id="loadingSpinner">
            <div class="loading-spinner">
                <div style="height: 80px; width: 80px; border-radius: 50%; background-color: white; display: flex; align-items: center; justify-content: center">
                    <img src="/static/images/icon.png" alt="Loading Spinner">
                </div>
            </div>
        </div>

    </head>
    <body>
    <style>
        body {
            background-image: url("/static/images/Frame_13OSUMKI_WEB.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
    </style>
    <nav class="navbar navbar-dark bg-dark position-fixed header">
        <div class="osumkiHeader">
            <a class="OSUMKILOGO" href="/">
                <span class="navbar-brand mb-0 h1">O!SUMKI</span>
            </a>
            <#if user.email??>
                <#if user.isAdmin()>
                    <div class="dropdown text-end">
                        <a href="/profile">
                            <img src="/static/images/adminAvatar.png"
                                 width="40" height="40" class="rounded-circle">
                        </a>
                    </div>
                <#elseif user.isModerator()>
                    <div class="dropdown text-end">
                        <a href="/profile">
                            <img src="/static/images/moderatorAvatar.png"
                                 width="40" height="40" class="rounded-circle" style="background-color: white">
                        </a>
                    </div>
                <#else>
                    <a class="rounded-circle" href="/profile" style="display: inline-block; background-color: white; width: 40px; height: 40px;
                    text-align: center; line-height: 40px; text-decoration: none;">
                        <span style="font-family: 'Marck Script', serif; font-size: 30px; color: black; text-decoration: none;">${user.name?substring(0, 1)}</span>
                    </a>
                </#if>
            <#else>
                <button class="btn btn-light my-2 my-sm-0" type="button"
                        onclick="window.location.href = '/login'">
                    Войти
                </button>
            </#if>
        </div>
    </nav>


    <div class="mainConteiner">
        <div class="content">
            <#nested/>
        </div>

        <div class="bg-dark navbar-dark pt-1 pb-1">
            <div class="container">
                <footer class="mt-3">
                    <ul class="nav justify-content-center border-bottom pb-3 mb-3">
                        <li class="nav-item text-white"><a href="/" class="nav-link px-2 text-white">Главная</a></li>
                        <li class="nav-item text-white"><a href="/profile" class="nav-link px-2 text-white">Личный кабинет</a></li>
                        <li class="nav-item text-white"><a href="https://yandex.ru/maps/-/CTSEbkq" target="_blank" class="nav-link px-2 text-white">Мы на карте</a></li>
                        <li class="nav-item text-white"><a href="/" class="nav-link px-2 text-white" data-toggle="modal" data-target="#helpModal">Помощь</a></li>
                        <li class="nav-item text-white"><a href="/About" class="nav-link px-2 text-white">О нас</a></li>
                    </ul>
                    <p class="text-center year text-white"></p>
                    <p class="text-white text-center">Сайт разработан <a href="https://vk.com/sceh9" class="CEH9INFO" rel="noreferrer" target="_blank">PorfInd</a></p>
                </footer>
            </div>
        </div>

        <div class="modal fade" id="helpModal" tabindex="-1" role="dialog" aria-labelledby="helpModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="helpModalLabel">Помощь</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Если у вас возникли вопросы, просьба обращаться в сообщения:</p>
                        <a href="https://chat.whatsapp.com/G9DlllGGXtj7zyH0HiyGPE" target="_blank"><img src="/static/images/WhatsApp.png" alt="WhatsApp" style="height: 40px; border-radius: 12px; margin-right: 20px"></a>
                        <a href="https://instagram.com/osumki_sochi?igshid=MzRlODBiNWFlZA==" target="_blank"><img src="/static/images/Instagram.png" alt="Instagram" style="height: 40px; border-radius: 12px; margin-right: 20px"></a>
                        <a href="https://vk.com/osumki_sochi" target="_blank"><img src="/static/images/VK.png" alt="VK" style="height: 40px; border-radius: 12px"></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        const copyRight = document.querySelector('.year')
        const currentYear = (new Date()).getFullYear()
        copyRight.innerText = '© Все права защищены ' + currentYear + ', O!SUMKI'
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            function showLoadingAnimation() {
                document.getElementById('loadingSpinner').style.display = 'block';
            }
            function hideLoadingAnimation() {
                document.getElementById('loadingSpinner').style.display = 'none';
            }

            window.addEventListener("load", hideLoadingAnimation);
        });
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/css/intlTelInput.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.13/js/intlTelInput.min.js"></script>
    <script>document.addEventListener("DOMContentLoaded", function () {
            var phoneInputs = document.querySelectorAll('.data-tel-input');

            var getInputNumbersValue = function (input) {
                // Return stripped input value — just numbers
                return input.value.replace(/\D/g, '');
            }

            var onPhonePaste = function (e) {
                var input = e.target,
                    inputNumbersValue = getInputNumbersValue(input);
                var pasted = e.clipboardData || window.clipboardData;
                if (pasted) {
                    var pastedText = pasted.getData('Text');
                    if (/\D/g.test(pastedText)) {
                        // Attempt to paste non-numeric symbol — remove all non-numeric symbols,
                        // formatting will be in onPhoneInput handler
                        input.value = inputNumbersValue;
                        return;
                    }
                }
            }

            var onPhoneInput = function (e) {
                var input = e.target,
                    inputNumbersValue = getInputNumbersValue(input),
                    selectionStart = input.selectionStart,
                    formattedInputValue = "";

                if (!inputNumbersValue) {
                    return input.value = "";
                }

                if (input.value.length != selectionStart) {
                    // Editing in the middle of input, not last symbol
                    if (e.data && /\D/g.test(e.data)) {
                        // Attempt to input non-numeric symbol
                        input.value = inputNumbersValue;
                    }
                    return;
                }

                if (["7", "8", "9"].indexOf(inputNumbersValue[0]) > -1) {
                    if (inputNumbersValue[0] == "9") inputNumbersValue = "7" + inputNumbersValue;
                    var firstSymbols = (inputNumbersValue[0] == "8") ? "8" : "+7";
                    formattedInputValue = input.value = firstSymbols + " ";
                    if (inputNumbersValue.length > 1) {
                        formattedInputValue += '(' + inputNumbersValue.substring(1, 4);
                    }
                    if (inputNumbersValue.length >= 5) {
                        formattedInputValue += ') ' + inputNumbersValue.substring(4, 7);
                    }
                    if (inputNumbersValue.length >= 8) {
                        formattedInputValue += '-' + inputNumbersValue.substring(7, 9);
                    }
                    if (inputNumbersValue.length >= 10) {
                        formattedInputValue += '-' + inputNumbersValue.substring(9, 11);
                    }
                } else {
                    formattedInputValue = '+' + inputNumbersValue.substring(0, 16);
                }
                input.value = formattedInputValue;
            }
            var onPhoneKeyDown = function (e) {
                // Clear input after remove last symbol
                var inputValue = e.target.value.replace(/\D/g, '');
                if (e.keyCode == 8 && inputValue.length == 1) {
                    e.target.value = "";
                }
            }
            for (var phoneInput of phoneInputs) {
                phoneInput.addEventListener('keydown', onPhoneKeyDown);
                phoneInput.addEventListener('input', onPhoneInput, false);
                phoneInput.addEventListener('paste', onPhonePaste, false);
            }
        })</script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"
            integrity="sha384-fbbOQedDUMZZ5KreZpsbe1LCZPVmfTnH7ois6mU1QK+m14rQ1l2bGBq41eYeM/fS"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        const input1 = document.getElementById('focusInput1')
        const input2 = document.getElementById('focusInput2')
        const input3 = document.getElementById('focusInput3')
        const input4 = document.getElementById('focusInput4')

        const select1 = document.querySelector('.SelectBrand')
        const select2 = document.querySelector('.SelectTitle')
        const select3 = document.querySelector('.SelectMaterial')
        const select4 = document.querySelector('.SelectSize')

        input1.addEventListener('focus', () => {
            select1.classList.add('Activated')
        })

        input2.addEventListener('focus', () => {
            select2.classList.add('Activated')
        })

        input3.addEventListener('focus', () => {
            select3.classList.add('Activated')
        })

        input4.addEventListener('focus', () => {
            select4.classList.add('Activated')
        })

        document.addEventListener('click', (e) => {
            if (e.target.id && e.target.id === 'varBtn' && e.target.id !== 'focusInput') {
                select1.classList.remove('Activated')
                select2.classList.remove('Activated')
                select3.classList.remove('Activated')
                select4.classList.remove('Activated')
                return
            }
            // select.classList.remove('Activated')
            if (!e.target.id) {
                select1.classList.remove('Activated')
                select2.classList.remove('Activated')
                select3.classList.remove('Activated')
                select4.classList.remove('Activated')

            }
        })

        const setInput1 = (text) => {
            document.getElementById("focusInput1").value = text;
            select1.classList.remove('Activated')
        }

        const setInput2 = (text) => {
            document.getElementById("focusInput2").value = text;
            select2.classList.remove('Activated')
        }

        const setInput3 = (text) => {
            document.getElementById("focusInput3").value = text;
            select3.classList.remove('Activated')
        }

        const setInput4 = (text) => {
            document.getElementById("focusInput4").value = text;
            select4.classList.remove('Activated')
        }
    </script>
    </body>
    </html>

</#macro>