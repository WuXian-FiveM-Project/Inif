$(function () {
    window.addEventListener('message', (event) => {
        var action = event.data.action
        switch (action) {
            case 'Show':
                $('#container').fadeIn();
                break
            case 'Hide':
                $('#container').fadeOut();
                break
            case 'SetMenu':
                event.data.Menu.forEach((item,index) => {
                    switch (item.Type) {
                        case 'Title':
                            $('#container').append(`<h1 id="title">${item.Text}</h1><hr><div id = "list"></div>`);
                            break
                        case 'HorizontalLine':
                            $('#list').append(`<hr>`);
                            break
                        case 'Text':
                            $('#list').append(`<p>${item.Text}</p><br>`);
                            break
                        case 'Button':
                            $("#list").append(
                                `<button onclick = postButton(${index+1})>${item.Text}</button>`
                            );
                            break
                        case 'NumberInput':
                            $("#list").append(
                                `<input class = "input" onchange = "postNumber(${index+1},this.value)" type = "number" ${item.MinValue ? "min = " + item.MinValue : ""} ${item.MaxValue ? "max = " + item.MaxValue : ""} ${item.DefaultValue ? "value = " + item.DefaultValue : ""}>`
                            );
                            break
                        case 'TextInput':
                            $("#list").append(
                                `<input class = "input" type="text" onchange = "postText(${index + 1},this.value)" ${item.Placeholder ? "placeholder = " + item.Placeholder : ""} ${item.DefaultValue ? "value = " + item.DefaultValue : ""}>`
                            );
                            break
                        case 'Color':
                            $("#list").append(
                                `<input type="color" class = "color" value="${item.DefaultColor}">`
                            );
                            break;
                        default: 
                            break
                    }
                })
                break
        }
    });
})


function postButton(index) {
    $.post(`https://${GetParentResourceName()}/ButtonClick`,
        JSON.stringify({
            index: index
        })
    )
}

function postNumber(index,number) {
    $.post(`https://${GetParentResourceName()}/ButtonClick`,
        JSON.stringify({
            index: index,
            number: number
        })
    )
}

function postText(index, number) {
    $.post(`https://${GetParentResourceName()}/ButtonClick`,
        JSON.stringify({
            index: index,
            number: number
        })
    )
}