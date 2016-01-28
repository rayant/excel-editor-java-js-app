package com.xml_tables_task.rest;

import org.springframework.web.bind.annotation.RestController;

/**
 * Created by Optical Illusion on 19.01.2016.
 */

@RestController
public class ClothRestController {

//
//
//    @Autowired
//    private ClothService clothService;
//
//    @RequestMapping(value = "/cloth/read/filtered", method = RequestMethod.POST,
//            consumes = MediaType.APPLICATION_JSON_VALUE,
//            produces = MediaType.APPLICATION_JSON_VALUE
//    )
//    public ResponseEntity<EntityPage<Cloth>> listFiltered(@RequestBody String clothFilter) throws IOException {
//        System.out.println(clothFilter);
//        ObjectMapper mapper = new ObjectMapper();
//        ClothFilter filter = mapper.readValue(clothFilter, ClothFilter.class);
//        System.err.println(filter);
//////        EntityPage<Cloth> clothEntityPage = clothService.listAllWithFilter(clothFilter);
////        if (clothEntityPage.getEntities().isEmpty()) {
//            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
////        }
////        return new ResponseEntity<>(clothEntityPage, HttpStatus.OK);
//    }
//
//    @RequestMapping(value = "/cloth/read/all", method = RequestMethod.POST,
//            consumes = MediaType.APPLICATION_JSON_VALUE,
//            produces = MediaType.APPLICATION_JSON_VALUE)
//    public ResponseEntity<EntityPage<Cloth>> listAll() {
//        EntityPage<Cloth> clothEntityPage = clothService.listAllWithFilter(new ClothFilter());
//        System.out.println("result: "+clothEntityPage);
//        if (clothEntityPage.getEntities().isEmpty()) {
//            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
//        }
//        return new ResponseEntity<>(clothEntityPage, HttpStatus.OK);
//    }

}
