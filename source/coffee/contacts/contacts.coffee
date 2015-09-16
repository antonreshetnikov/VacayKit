class Contacts
    constructor: ->
        @form = $ '.contacts__form'
        if @form.length == 0
            return
        @success = $ 'section.contacts.contacts_success'
        @form.on 'submit', @sendMessage

    sendMessage: (event)=>
        event.preventDefault()
        $.ajax({
            type: "POST",
            url: "https://mandrillapp.com/api/1.0/messages/send.json",
            data: {
                "key": "aG3qodBxJFzJhMPyO1y_EQ",
                "message": {
                    "to": [{
                        "email": "ravenb@mail.ru",
                        "name": "Anton Nemtsev",
                        "type": "to"
                        }],
                    "subject": "Message from VacayKit contact us form",
                    "from_email": @form.find('input[name="email"]').val().trim(),
                    "from_name": @form.find('input[name="name"]').val().trim(),
                    "text": @form.find('textarea[name="message"]').val().trim()
                    }
                }
            }).done (response)=>
                @form.closest('section.contacts').hide()
                @success.show()
                console.log(response)

$(document).ready ->
    new Contacts
