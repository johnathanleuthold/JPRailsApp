// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require_tree .

$(document).ready(function(){
    var Username = $('#user_username'),
        UsernameExists = $('#username_exists'),
        UsernameError = $('#username_error'),
        Email = $('#user_email'),
        EmailExists =$('#email_exists'),
        EmailError = $('#email_error'),
        Password = $('#user_password'),
        PasswordConfirmation = $('#user_password_confirmation'),
        PasswordError = $('#password_error'),
        PasswordConfirmationError = $('#password_confirmation_error');
    
    $('span').hide();
    
    function validateUserAvailability()
    {
        var usernameExistsError = "";
        $.ajax(
            {
                type: "GET",
                url: "/users/existinguser",
                data: {username: Username.val()},
                dataType: "text",
                /*
                complete: function()
                {
                    //alert("AJAX complete");
                },
                */
                success: function(data)
                {
                    if (data === "exists")
                    {
                        usernameExistsError = "Username is already in use.";
                        UsernameExists.show().text(usernameExistsError).addClass('errortext');
                        Username.addClass('errorfield');
                        //alert(usernameExistsError);
                    }
                    else
                    {
                        usernameExistsError =  "";
                        //Username.removeClass('errorfield');
                        UsernameExists.hide();
                        //alert("username is available");
                    }
                }
               /* 
               error: function()
                {
                    alert("broken");
                }
                */
            });
        return usernameExistsError;
    }
    
    function validateEmailAvailability()
    {
        var EmailExistsError = "";
        $.ajax(
            {
                type: "GET",
                url: "/users/existingemail",
                data: {email: Email.val()},
                dataType: "text",
                /*
                complete: function()
                {
                    //alert("AJAX complete");
                },
                */
                success: function(data)
                {
                    if (data === "exists")
                    {
                        EmailExistsError = "Email is already in use.";
                        EmailExists.show().text(EmailExistsError).addClass('errortext');
                        Email.addClass('errorfield');
                        //alert(usernameExistsError);
                    }
                    else
                    {
                        EmailExistsError =  "";
                        //Email.removeClass('errorfield');
                        EmailExists.hide();
                        //alert("username is available");
                    }
                }
               /* 
               error: function()
                {
                    alert("broken");
                }
                */
            });
        return EmailExistsError;
    }
    
    function validateUsername()
    {
        var UsernameVal = Username.val();
        var ErrorList = "";
        
        if (UsernameVal.length === 0)
        {
            ErrorList += "Username is a required field.";
        }
        else
        {
            if (UsernameVal.length < 3)
            {
                ErrorList += " Username length must be at least 3 characters.";
            }
            else
            {
                if (UsernameVal.length > 25)
                {
                    ErrorList += " Username cannot be longer than 25 characters.";
                }
            }
        }
        
        //alert(usernameExistsError);
        if (ErrorList === "")
        {
            UsernameError.hide();
            Username.removeClass('errorfield');
        }
        else
        {
            UsernameError.show().text(ErrorList).addClass('errortext');
            Username.addClass('errorfield');
        }
    }
    
    function validateEmail()
    {
        var ErrorList = "";
        var EmailVal = Email.val();
        var Regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Za-z]{2,20}$/i;
        if (!Regex.test(EmailVal))
        {
            ErrorList += " Email form is invalid.";
            EmailError.show().text(ErrorList).addClass('errortext');
            Email.addClass('errorfield');
            return false;
        }
        else
        {
            Email.removeClass('errorfield');
            EmailError.hide();
            return true;
        }
    }
    
    function validatePassword()
    {
        var ErrorList = "";
        if (Password.val().length === "")
        {
            ErrorList += "Password is a required field.";
        }
        else
        {
            if (Password.val().length < 6)
            {
                ErrorList += " Password length must be at least 6 characters.";
            }
            else
            {
                if (Password.val().length > 35)
                {
                    ErrorList += " Password length cannot be greater than 35 characters.";
                }
            }
        }
        
        if  (ErrorList === "")
        {
            PasswordError.hide();
            Password.removeClass('errorfield');
        }
        else
        {
            PasswordError.show().text(ErrorList).addClass('errortext');
            Password.addClass('errorfield');
        }
    }
    
    function validateConfirmation()
    {
        if (Password.val() === PasswordConfirmation.val())
        {
            PasswordConfirmationError.hide();
            PasswordConfirmation.removeClass('errorfield');
        }
        else
        {
            PasswordConfirmationError.show().text("Password confirmation does not match password.").addClass('errortext');
            PasswordConfirmation.addClass('errorfield');
        }
    }
    
    Username.keyup(function()
    {
        validateUsername();
    });
    
    Username.blur(function()
    {
       validateUserAvailability(); 
    });
    
    Email.keyup(function()
    {
        validateEmail();
    });
    
    Password.keyup(function()
    {
       validatePassword(); 
    });
    
    PasswordConfirmation.keyup(function()
    {
       validateConfirmation(); 
    });
    
    Email.blur(function()
    {
       validateEmailAvailability(); 
  });
});

/*$('#new_user').validate({
debug: true,
rules: {
"#user_email": {required: true},
"#user_password": {required: true, minlength: 6, maxlength: 20}
},
messages: {
"#user_email": "Bad emailz",
"#user_password": {required: "need pass!", minlength: "Too skinny", maxlength:
    "too fat"},
},
});
*/