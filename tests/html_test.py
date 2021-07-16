from json import load

def string_finder(file_object, string_object):
    with file as open(html_object, 'r+'):
        return list(map(lambda x: string_object in x, file.readlines()))

def return_true_if_list_is_more_than_blank(list_object):
    if not list_object == []:
        return True
    if list_object == []:
        return False

def config_loader(file_name):
    with file as open(file_name, 'r+'):
        return load(file_name)

if __name__ == '__main__':
    config = config_loader('html_test_config.json')
    return_true_if_list_is_more_than_blank(string_finder(config["html_presence_config"]["file_name"], config["html_presence_config"]["string_name"]))
