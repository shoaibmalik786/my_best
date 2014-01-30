# Delete confirmation modals
# https://gist.github.com/trey/1765619
# https://gist.github.com/postpostmodern/1862479
# http://lesseverything.com/blog/archives/2012/07/18/customizing-confirmation-dialog-in-rails/
# http://www.pjmccormick.com/nicer-rails-confirm-dialogs-and-not-just-delete-methods

$(document).ready ->

  $.rails.extractData = (link, param, defaultValue) ->
    return link.data(param) if link.data(param)
    defaultValue

  $.rails.allowAction = (link) ->
    # If there's no data-confirm attribute, there's nothing to confirm
    return true unless link.data('confirm')

    title = $.rails.extractData(link, 'title', 'Please confirm!')
    message = $.rails.extractData(link, 'confirm', 'Are you sure?')
    action = $.rails.extractData(link, 'action', 'Go ahead')

    # Clone the clicked link (probably a delete link) so we can use it in the dialog box.
    $link = link.clone()
    .removeAttr('class') # We don't necessarily want the same styling as the original link/button.
    .removeAttr('data-confirm') # We don't want to pop up another confirmation (recursion)
    .addClass('btn').addClass('btn-danger')
    .html(action)

    # Create the modal box with the message
    html = """
            <div aria-hidden="false" aria-labelledby="confirmationDialogLabel" class="modal fade in" role="dialog" tabindex="-1" >
              <div class="modal-dialog">
                <div class="modal-content" id="myModal">
                  <div class="modal-header">
                    <a class="close" data-dismiss="modal">×</a>
                    <h4>#{title}</h4>
                  </div>
                  <div class="modal-body">
                    <div>#{message}</div>
                  </div>
                  <div class="modal-footer">
                    <a data-dismiss="modal" class="btn">Cancel</a>
                  </div>
                </div>
              </div>
            </div>
           """

    $html = $(html)
    $html.find('.modal-footer').append($link) # Add the new button to the modal box
    $html.modal() # Pop it up
    return false # Prevent the original link from working