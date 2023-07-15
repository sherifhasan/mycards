import 'package:challenge/application/features/cards/card_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

class CardsMobileView extends HookConsumerWidget {
  const CardsMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cardCubitProvider);
    final cardsCubit = ref.watch(cardCubitProvider.bloc);

    useEffect(() {
      cardsCubit.getCards();
      return null;
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: Stack(
        children: [
          state.when(
            initial: () => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            data: (cards) => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.75,
                        child: StackedCardCarousel(
                          type: StackedCardCarouselType.cardsStack,
                          spaceBetweenItems:
                              MediaQuery.sizeOf(context).height * 0.60,
                          items: cards
                              .map((card) => Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    elevation: 4,
                                    child: SwipeActionCell(
                                      key: const ObjectKey('1'),
                                      backgroundColor: Colors.transparent,
                                      trailingActions: <SwipeAction>[
                                        SwipeAction(
                                            performsFirstActionWithFullSwipe:
                                                true,
                                            backgroundRadius: 18,
                                            content: const Center(
                                                child: Icon(
                                                    CupertinoIcons.delete,
                                                    size: 40,
                                                    color: Color(0xffD93838))),
                                            onTap: (CompletionHandler
                                                handler) async {
                                              handler(true);
                                              cardsCubit.removeCard(card);
                                            },
                                            color: const Color(0xFFE7837C)),
                                      ],
                                      leadingActions: <SwipeAction>[
                                        SwipeAction(
                                            performsFirstActionWithFullSwipe:
                                                true,
                                            backgroundRadius: 18,
                                            content: Center(
                                                child: Image.asset(
                                                    'assets/images/pencil.png')),
                                            onTap: (CompletionHandler
                                                handler) async {
                                              handler(false);
                                              //for edit
                                              // todo navigate to add screen

                                            },
                                            color: const Color(0xFF78F5EE)),
                                      ],
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.58,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/card_bg.png'),
                                                fit: BoxFit.fill)),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(30),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      card.fullName,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xFFF3F5F7)),
                                                    ),
                                                    Text(
                                                      card.phoneNumber,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xccF3F5F7)),
                                                    ),
                                                    Text(
                                                      card.email,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xccF3F5F7)),
                                                    ),
                                                  ]),
                                            ),
                                            Positioned(
                                                left: 30,
                                                right: 30,
                                                bottom: 72,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'IBAN',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xFFF3F5F7)),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            card.iban,
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: const Color(
                                                                    0xffF3F5F7)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Positioned(
                                                right: 20,
                                                bottom: 20,
                                                child: Image.asset(
                                                  'assets/images/visa_logo.png',
                                                  height: 20,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                        Color(0xff181D29)),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 36, vertical: 16))),
                onPressed: () {
                  // todo navigate to add screen
                },
                child: Text('New',
                    style: GoogleFonts.poppins(
                        color: const Color(0xffF5F5F7),
                        fontSize: 16,
                        letterSpacing: 0.25,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
