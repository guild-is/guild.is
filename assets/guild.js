window.onload = function () {
  var cursor = document.getElementById('cursor')
  var input = document.getElementById('email')
  var signup = document.getElementById('signup')

  input.addEventListener('focus', function () {
    cursor.classList.add('dn')
  })

  input.addEventListener('blur', function () {
    if (input.value.length === 0) {
      cursor.classList.remove('dn')
    }
  })

  input.addEventListener('input', function (e) {
    var value = e.target.value
    var isValid = validEmail(value)

    if (isValid) {
      signup.classList.remove('dn')
    } else {
      signup.classList.add('dn')
    }
  })

  function validEmail (email) {
    var emailRegex = /^([A-Za-z0-9_\-.+])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,})$/
    return emailRegex.test(email)
  }
}
